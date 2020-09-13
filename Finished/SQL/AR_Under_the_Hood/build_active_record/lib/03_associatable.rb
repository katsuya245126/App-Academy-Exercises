require_relative '02_searchable'
require 'active_support/inflector'
# rubocop: disable all

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # if options.empty?
    #   @foreign_key = (name.to_s + '_id').to_sym
    #   @primary_key = :id
    #   @class_name = name.singularize.capitalize
    # else
    #   options.each do |k, v|
    #     case k
    #     when :primary_key then @primary_key = v
    #     when :foreign_key then @foreign_key = v
    #     when :class_name then @class_name = v
    #     end
    #   end
    # end

    defaults = {
      foreign_key: "#{name}_id".to_sym,
      primary_key: :id,
      class_name: name.to_s.camelcase
    }
    p "options in BelongsToOptions: #{options}"
    defaults.each do |k, v|
      value = options[k] || v
      self.send("#{k}=", value)
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    defaults = {
      foreign_key: "#{self_class_name.underscore}_id".to_sym,
      primary_key: :id,
      class_name: name.to_s.camelcase.singularize
    }

    defaults.each do |k, v|
      value = options[k] || v
      self.send("#{k}=", value)
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, attributes = {})
    self.assoc_options[name] = BelongsToOptions.new(name, attributes)

    define_method(name) do
      options = self.class.assoc_options[name]
      foreign_key = self.send(options.foreign_key)
      options.model_class.where(id: foreign_key).first
    end
  end

  def has_many(name, attributes = {})
    define_method(name.to_s.pluralize) do
      options = HasManyOptions.new(name, self.class.name, attributes)
      primary_key = self.send(options.primary_key)
      options.model_class.where(options.foreign_key => primary_key)
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @assoc_options ||= {}
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
