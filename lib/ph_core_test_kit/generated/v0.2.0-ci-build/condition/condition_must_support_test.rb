# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module PHCoreTestKit
  module PHCoreV020_CI_BUILD
    class ConditionMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the Condition resources returned'
      description %(
        PH Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the PH Core Server Capability
        Statement. This test will look through the Condition resources
        found previously for the following must support elements:

        * Condition.bodySite
        * Condition.bodySite.coding
        * Condition.bodySite.text
        * Condition.category
        * Condition.clinicalStatus
        * Condition.clinicalStatus.coding
        * Condition.clinicalStatus.text
        * Condition.code
        * Condition.code.coding
        * Condition.code.text
        * Condition.encounter
        * Condition.evidence.code
        * Condition.evidence.code.coding
        * Condition.evidence.code.text
        * Condition.note
        * Condition.severity
        * Condition.stage.summary
        * Condition.stage.summary.coding
        * Condition.stage.summary.text
        * Condition.stage.type
        * Condition.stage.type.coding
        * Condition.stage.type.text
        * Condition.subject
        * Condition.verificationStatus
        * Condition.verificationStatus.coding
        * Condition.verificationStatus.text
      )

      id :ph_core_v020_ci_build_condition_must_support_test

      def resource_type
        'Condition'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(
                                                                            File.join(__dir__,
                                                                                      'metadata.yml'), aliases: true
                                                                          ))
      end

      def scratch_resources
        scratch[:condition_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
