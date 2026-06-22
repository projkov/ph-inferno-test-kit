# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module PHCoreTestKit
  module PHCoreV020_CI_BUILD
    class PractitionerMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the Practitioner resources returned'
      description %(
        PH Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the PH Core Server Capability
        Statement. This test will look through the Practitioner resources
        found previously for the following must support elements:

        * Practitioner.address
        * Practitioner.birthDate
        * Practitioner.communication
        * Practitioner.communication.coding
        * Practitioner.communication.text
        * Practitioner.gender
        * Practitioner.name
        * Practitioner.name.family
        * Practitioner.name.given
        * Practitioner.qualification.code
        * Practitioner.qualification.code.coding
        * Practitioner.qualification.code.text
        * Practitioner.telecom
      )

      id :ph_core_v020_ci_build_practitioner_must_support_test

      def resource_type
        'Practitioner'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(
                                                                            File.join(__dir__,
                                                                                      'metadata.yml'), aliases: true
                                                                          ))
      end

      def scratch_resources
        scratch[:practitioner_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
