# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module PHCoreTestKit
  module PHCoreV020_CI_BUILD
    class ProcedureMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the Procedure resources returned'
      description %(
        PH Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the PH Core Server Capability
        Statement. This test will look through the Procedure resources
        found previously for the following must support elements:

        * Procedure.bodySite
        * Procedure.bodySite.coding
        * Procedure.bodySite.text
        * Procedure.category
        * Procedure.category.coding
        * Procedure.category.text
        * Procedure.code
        * Procedure.code.coding
        * Procedure.code.text
        * Procedure.complication
        * Procedure.complication.coding
        * Procedure.complication.text
        * Procedure.encounter
        * Procedure.focalDevice.action
        * Procedure.focalDevice.action.coding
        * Procedure.focalDevice.action.text
        * Procedure.followUp
        * Procedure.followUp.coding
        * Procedure.followUp.text
        * Procedure.outcome
        * Procedure.outcome.coding
        * Procedure.outcome.text
        * Procedure.performed[x]
        * Procedure.performer.function
        * Procedure.performer.function.coding
        * Procedure.performer.function.text
        * Procedure.reasonCode
        * Procedure.reasonCode.coding
        * Procedure.reasonCode.text
        * Procedure.reasonReference
        * Procedure.status
        * Procedure.statusReason
        * Procedure.statusReason.coding
        * Procedure.statusReason.text
        * Procedure.subject
        * Procedure.usedCode
        * Procedure.usedCode.coding
        * Procedure.usedCode.text
      )

      id :ph_core_v020_ci_build_procedure_must_support_test

      def resource_type
        'Procedure'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(
                                                                            File.join(__dir__,
                                                                                      'metadata.yml'), aliases: true
                                                                          ))
      end

      def scratch_resources
        scratch[:procedure_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
