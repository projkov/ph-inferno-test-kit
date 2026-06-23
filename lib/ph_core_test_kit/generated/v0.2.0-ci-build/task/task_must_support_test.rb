# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module PHCoreTestKit
  module PHCoreV020_CI_BUILD
    class TaskMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the Task resources returned'
      description %(
        PH Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the PH Core Server Capability
        Statement. This test will look through the Task resources
        found previously for the following must support elements:

        * Task.businessStatus
        * Task.businessStatus.coding
        * Task.businessStatus.text
        * Task.code
        * Task.code.coding
        * Task.code.text
        * Task.executionPeriod
        * Task.for
        * Task.input.type
        * Task.input.type.coding
        * Task.input.type.text
        * Task.input.value[x]:valueCodeableConcept
        * Task.input.value[x]:valueCodeableConcept.coding
        * Task.input.value[x]:valueCodeableConcept.text
        * Task.note
        * Task.output.type
        * Task.output.type.coding
        * Task.output.type.text
        * Task.output.value[x]:valueCodeableConcept
        * Task.output.value[x]:valueCodeableConcept.coding
        * Task.output.value[x]:valueCodeableConcept.text
        * Task.performerType
        * Task.performerType.coding
        * Task.performerType.text
        * Task.reasonCode
        * Task.reasonCode.coding
        * Task.reasonCode.text
        * Task.status
        * Task.statusReason
        * Task.statusReason.coding
        * Task.statusReason.text
      )

      id :ph_core_v020_ci_build_task_must_support_test

      def resource_type
        'Task'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(
                                                                            File.join(__dir__,
                                                                                      'metadata.yml'), aliases: true
                                                                          ))
      end

      def scratch_resources
        scratch[:task_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
