# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/read_test'

module PHCoreTestKit
  module PHCoreV020_CI_BUILD
    class ProvenanceReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct Provenance resource from Provenance read interaction'
      description 'A server SHALL support the Provenance read interaction.'

      input :provenance_ids,
            title: 'Provenance IDs',
            description: 'Comma separated list of provenance IDs that in sum contain all MUST SUPPORT elements',
            default: '',
            optional: true

      id :ph_core_v020_ci_build_provenance_read_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def resource_type
        'Provenance'
      end

      def scratch_resources
        scratch[:provenance_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
