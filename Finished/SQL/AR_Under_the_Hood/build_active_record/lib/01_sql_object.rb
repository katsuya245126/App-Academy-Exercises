require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.
# rubocop:disable all

class SQLObject
  def self.columns
    return @columns if @columns

    columns = DBConnection.execute2(<<-SQL)
      SELECT *
        FROM #{table_name}
       LIMIT 0
    SQL

    @columns = columns.first.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col) do 
        attributes[col]
      end

      define_method("#{col}=") do |val|
        attributes[col] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= name.underscore.pluralize
  end

  def self.all
    data = DBConnection.execute(<<-SQL)
      SELECT *
        FROM #{table_name}
    SQL

    parse_all(data)
  end

  def self.parse_all(results)
    results.map { |row| self.new(row) }
  end

  def self.find(id)
    data = DBConnection.execute(<<-SQL, id)
      SELECT *
        FROM #{table_name}
       WHERE id = ?
       LIMIT 1
    SQL

    parse_all(data).first
  end

  def initialize(params = {})
    params.each do |k, v|
      k = k.to_sym

      if self.methods.include?(k)
        self.send("#{k}=", v)
      else
        raise "unknown attribute '#{k}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    columns = self.class.columns
    columns.map { |col| self.send(col) }
  end

  def insert
    columns = self.class.columns.drop_while { |col| col == :id }
    col_names = columns.map(&:to_s).join(", ")
    col_values = attribute_values.drop(1)

    question_marks = (["?"] * columns.count).join(", ")
    
    DBConnection.execute(<<-SQL, *col_values)
      INSERT INTO #{self.class.table_name}(#{col_names})
      VALUES (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    columns = self.class.columns.drop_while { |col| col == :id }
    set_col = columns.map { |col| "#{col} = ?" }.join(", ")
    col_values = attribute_values.drop(1)

    DBConnection.execute(<<-SQL, *col_values, id)
      UPDATE #{self.class.table_name}
         SET #{set_col}
       WHERE id = ?
    SQL
  end

  def save
    id.nil? ? insert : update
  end
end
