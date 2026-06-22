# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module PHCoreTestKit
  module PHCoreV020_CI_BUILD
    class ObservationMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the Observation resources returned'
      description %(
        PH Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the PH Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.bodySite
        * Observation.bodySite.coding
        * Observation.bodySite.text
        * Observation.category
        * Observation.category.coding
        * Observation.category.text
        * Observation.code
        * Observation.code.coding
        * Observation.code.text
        * Observation.component.code
        * Observation.component.code.coding
        * Observation.component.code.text
        * Observation.component.dataAbsentReason
        * Observation.component.dataAbsentReason.coding
        * Observation.component.dataAbsentReason.text
        * Observation.component.interpretation
        * Observation.component.interpretation.coding
        * Observation.component.interpretation.text
        * Observation.component.value[x]:valueCodeableConcept
        * Observation.component.value[x]:valueCodeableConcept.coding
        * Observation.component.value[x]:valueCodeableConcept.text
        * Observation.dataAbsentReason
        * Observation.dataAbsentReason.coding
        * Observation.dataAbsentReason.text
        * Observation.interpretation
        * Observation.interpretation.coding
        * Observation.interpretation.text
        * Observation.method
        * Observation.method.coding
        * Observation.method.text
        * Observation.referenceRange.appliesTo
        * Observation.referenceRange.appliesTo.coding
        * Observation.referenceRange.appliesTo.text
        * Observation.referenceRange.type
        * Observation.referenceRange.type.coding
        * Observation.referenceRange.type.text
        * Observation.value[x]:valueCodeableConcept
        * Observation.value[x]:valueCodeableConcept.coding
        * Observation.value[x]:valueCodeableConcept.text
      )

      id :ph_core_v020_ci_build_observation_must_support_test

      def resource_type
        'Observation'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(
                                                                            File.join(__dir__,
                                                                                      'metadata.yml'), aliases: true
                                                                          ))
      end

      def scratch_resources
        scratch[:observation_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
