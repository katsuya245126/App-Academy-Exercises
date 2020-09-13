require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options =  through_options.model_class.assoc_options[source_name]

      through_pk = through_options.primary_key
      through_fk = through_options.foreign_key
      through_name = through_options.table_name

      source_pk = source_options.primary_key
      source_fk = source_options.foreign_key
      source_name = source_options.table_name

      cat_owner = self.send(through_fk)

      data = DBConnection.execute(<<-SQL, cat_owner)
        SELECT #{source_name}.*
          FROM #{through_name}
               JOIN #{source_name}
               ON #{through_name}.#{source_fk} = #{source_name}.#{source_pk}
         WHERE #{through_name}.#{through_pk} = ?
      SQL

      source_options.model_class.parse_all(data).first
    end
  end
end
