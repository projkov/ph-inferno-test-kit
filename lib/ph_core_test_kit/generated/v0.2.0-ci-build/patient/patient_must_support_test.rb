# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module PHCoreTestKit
  module PHCoreV020_CI_BUILD
    class PatientMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the Patient resources returned'
      description %(
        PH Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the PH Core Server Capability
        Statement. This test will look through the Patient resources
        found previously for the following must support elements:

        * Patient.address
        * Patient.birthDate
        * Patient.communication.language
        * Patient.communication.language.coding
        * Patient.communication.language.text
        * Patient.contact.address
        * Patient.contact.relationship
        * Patient.contact.relationship.coding
        * Patient.contact.relationship.text
        * Patient.gender
        * Patient.identifier:PHCorePhilHealthID
        * Patient.identifier:PHCorePhilSysID
        * Patient.maritalStatus
        * Patient.maritalStatus.coding
        * Patient.maritalStatus.text
        * Patient.name
        * Patient.telecom
      )

      id :ph_core_v020_ci_build_patient_must_support_test

      def resource_type
        'Patient'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(
                                                                            File.join(__dir__,
                                                                                      'metadata.yml'), aliases: true
                                                                          ))
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
