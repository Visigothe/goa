ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
# require "minitest/reporters"
# Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new(color: true)]

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  def self.testing_klass
    self.name.chomp("Test")
  end

  def testing_klass
    self.class.testing_klass
  end

  def self.testing_instance
    FactoryGirl.build testing_klass.underscore.to_sym
  end

  def testing_instance
    self.class.testing_instance
  end

  def self.has_valid_factory
    define_method("test_factory_is_valid") {
      assert testing_instance.valid?
    }
  end

  def self.responds_to message
    define_method("test_responds_to_#{message.to_s}") {
      assert_respond_to testing_instance, message
    }
  end

  def self.validates_presence_of field
    define_method("test_presence_of_#{field.to_s}_is_required") {
      test_instance = testing_instance

      # Test that the initial object is valid
      assert test_instance.valid?

      # Test that it becomes invalid by removing the field
      temp = test_instance.send(field)
      test_instance.send("#{field}=", nil)
      refute test_instance.valid?
      assert(test_instance.errors.include?(field), "Expected an error on validation")

      # Make object valid again
      test_instance.send("#{field}=", temp)
      assert test_instance.valid?
    }
  end

  def self.validates_numericality_of field, constraint, number
    define_method("test_#{field.to_s}_#{constraint}_#{number}") {
      test_instance = testing_instance

      # Test that the initial object is valid
      assert test_instance.valid?

      invalid_number = case constraint
      when :greater_than_or_equal_to
        number - 1
      when :less_than_or_equal_to
        number + 1
      end

      # Test that it becomes invalid when string is invalid
      temp = test_instance.send(field)
      test_instance.send("#{field}=", invalid_number)
      refute test_instance.valid?
      assert(test_instance.errors.include?(field), "Expected an error on validation")

      # Make object valid again
      test_instance.send("#{field}=", temp)
      assert test_instance.valid?
    }
  end

  # TODO: Refactor so that this and make it more rigorous
  def self.validates_inclusion_of field, valid_values
    define_method("test_inclusion_of_#{field.to_s}") {
      test_instance = testing_instance

      # Test that the initial object is valid
      assert test_instance.valid?

      # Test that it becomes invalid when string is invalid
      temp = test_instance.send(field)
      test_instance.send("#{field}=", nil)
      refute test_instance.valid?
      assert(test_instance.errors.include?(field), "Expected an error on validation")

      # Test that all the values are valid
      valid_values.each do |value|
        test_instance.send("#{field}=", value)
        assert test_instance.valid?
      end

      # Make object valid again
      test_instance.send("#{field}=", temp)
      assert test_instance.valid?
    }
  end

  # def self.validates_uniqueness_of field
  #   define_method("test_uniqueness_of_#{field.to_s}") {
  #     test_instance = testing_instance

  #     # Test that the initial object is valid
  #     assert test_instance.valid?

  #     # Test that a duplicate object is not valid
  #     duplicate_instance = test_instance.dup
  #     test_instance.save
  #     refute duplicate_instance.valid?
  #   }
  # end

  # def self.validates_format_of field, invalid_string
  #   define_method("test_#{invalid_string}_is_not_a_valid_#{field.to_s}_format") {
  #     test_instance = testing_instance

  #     # Test that the initial object is valid
  #     assert test_instance.valid?

  #     # Test that it becomes invalid when string is invalid
  #     temp = test_instance.send(field)
  #     test_instance.send("#{field}=", invalid_string)
  #     refute test_instance.valid?
  #     assert(test_instance.errors.include?(field), "Expected an error on validation")

  #     # Make object valid again
  #     test_instance.send("#{field}=", temp)
  #     assert test_instance.valid?
  #   }
  # end

  # def self.has_scope_for name, included_options, excluded_options
  #   define_method("test_#{name}_scope") {
  #     included_object = FactoryGirl.create testing_klass.underscore.to_sym, included_options
  #     excluded_object = FactoryGirl.create testing_klass.underscore.to_sym, excluded_options
  #     collection = testing_klass.constantize.send(name)
  #     assert_includes(collection, included_object)
  #     refute_includes(collection, excluded_object)
  #   }
  # end

  # def self._association type, model
  #   define_method("test_#{testing_klass}_#{type}_#{model}") {
  #     associations = testing_klass.constantize.reflect_on_all_associations(type).map {|association| association.name}
  #     assert(associations.include?(model), "Expected #{testing_klass} to #{type} #{model}")
  #   }
  # end

  # def self.has_many model
  #   _association(:has_many, model)
  # end

  # # TODO: Write a test helper for has_many through association

  # def self.has_one model
  #   _association(:has_one, model)
  # end

  # def self.belongs_to model
  #   _association(:belongs_to, model)
  # end

  # def self.accepts_nested_attributes_for model
  #   define_method("test_#{testing_klass}_nested_attributes_for_#{model}") {
  #     assert_includes(testing_klass.constantize.nested_attributes_options, model)
  #   }
  # end
end
