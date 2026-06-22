# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/reference_resolution_test'

module PHCoreTestKit
  module PHCoreV020_CI_BUILD
    class EncounterReferenceResolutionTest < Inferno::Test
      include InfernoSuiteGenerator::ReferenceResolutionTest

      title 'MustSupport references within Encounter resources are valid'
      description %(
        This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding PH Core profile.

        Elements which may provide external references include:

        * Encounter.hospitalization.origin
        * Encounter.location.location
        * Encounter.reasonReference
        * Encounter.serviceProvider
        * Encounter.subject
      )

      id :ph_core_v020_ci_build_encounter_reference_resolution_test

      def resource_type
        'Encounter'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(
                                                                            File.join(__dir__,
                                                                                      'metadata.yml'), aliases: true
                                                                          ))
      end

      def scratch_resources
        scratch[:encounter_resources] ||= {}
      end

      run do
        perform_reference_resolution_test(scratch_resources[:all], {})
      end
    end
  end
end
