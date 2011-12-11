# encoding: UTF-8

module ActiveModel
  module Validations

    class CodiceFiscaleValidator < ActiveModel::EachValidator

      # Validator kind
      def kind
        :codice_fiscale
      end

      def validate_each(record, attribute, value)
        record.errors[attribute] << "non è un codice fiscale valido" unless CodiceFiscale::CF.valid?(value)
      end
    end

    module HelperMethods
      # Validates that the specified attributes are valid italian fiscal codes. Example:
      #
      #   class Person < ActiveRecord::Base
      #     validates_codice_fiscale_compliance_of :codice_fiscale_code
      #   end

      def validates_codice_fiscale_of (*attr_names)
        validates_with CodiceFiscaleValidator, _merge_attributes(attr_names)
      end
    end

  end

end
