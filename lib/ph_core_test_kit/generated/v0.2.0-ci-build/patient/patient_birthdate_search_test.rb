# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/search_test'
require 'inferno_suite_generator/core/group_metadata'
require 'inferno_suite_generator/utils/helpers'

module PHCoreTestKit
  module PHCoreV020_CI_BUILD
    class PatientBirthdateSearchTest < Inferno::Test
      include InfernoSuiteGenerator::SearchTest

      title '(SHOULD) Server returns valid results for Patient search by birthdate'
      description %(
A server SHOULD support searching by
birthdate on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[PH Core Server CapabilityStatement](https://fhir.doh.gov.ph/phcore/CapabilityStatement/ph-core-server)

      )

      id :ph_core_v020_ci_build_patient_birthdate_search_test
      optional

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def self.properties
        @properties ||= InfernoSuiteGenerator::SearchTestProperties.new(
          resource_type: 'Patient',
          search_param_names: ['birthdate']
        )
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

      def keep_all_search_results?
        false
      end

      run do
        run_search_test
      end
    end
  end
end
