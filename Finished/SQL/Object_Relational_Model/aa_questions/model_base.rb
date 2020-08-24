require 'active_support/inflector'
require_relative 'questions_database'

class ModelBase
  def self.table
    self.to_s.tableize
  end

  def attributes
    instance_variables = self.instance_variables
    attr = {}

    instance_variables.each do |inst_var|
      attr[inst_var[1..-1]] = instance_variable_get(inst_var)
    end

    attr
  end

  def self.all
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT *
      FROM #{table}
    SQL

    data.map { |datum| self.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
        FROM #{table}
       WHERE id = ?
    SQL

    return nil if data.empty?

    self.new(data.first)
  end

  def save
    self.id.nil? ? create : update
  end

  def self.where(options)
    condition = options.keys.map { |var| "#{var} = ?" }.join(' AND ')
    values = options.values

    data = QuestionsDatabase.instance.execute(<<-SQL, *values)
      SELECT *
        FROM #{table}
       WHERE #{condition}
    SQL

    return nil if data.empty?

    data.map { |datum| self.new(datum) }
  end

  def create
    raise 'This data already exists in the database' unless id.nil?

    instance_variables = attributes
    instance_variables.delete('id')
    column = instance_variables.keys.join(', ')
    placeholder = (['?'] * instance_variables.length).join(', ')
    values = instance_variables.values

    QuestionsDatabase.instance.execute(<<-SQL, *values)
      INSERT INTO #{self.class.table} (#{column})
      VALUES (#{placeholder})
    SQL

    self.id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise 'This data does not exist in the database' if id.nil?

    instance_variables = attributes
    instance_variables.delete('id')
    set_values = instance_variables.keys.map { |var| "#{var} = ?" }.join(', ')
    values = instance_variables.values

    QuestionsDatabase.instance.execute(<<-SQL, *values, id)
      UPDATE #{self.class.table}
         SET #{set_values}
       WHERE id = ?
    SQL

    self
  end
end
