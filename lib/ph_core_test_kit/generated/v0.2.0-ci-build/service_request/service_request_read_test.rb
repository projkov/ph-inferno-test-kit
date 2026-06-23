# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/read_test'

module PHCoreTestKit
  module PHCoreV020_CI_BUILD
    class ServiceRequestReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct ServiceRequest resource from ServiceRequest read interaction'
      description 'A server SHALL support the ServiceRequest read interaction.'

      id :ph_core_v020_ci_build_service_request_read_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def resource_type
        'ServiceRequest'
      end

      def scratch_resources
        scratch[:service_request_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
