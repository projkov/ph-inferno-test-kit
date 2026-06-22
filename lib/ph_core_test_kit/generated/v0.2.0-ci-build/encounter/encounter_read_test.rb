# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/read_test'

module PHCoreTestKit
  module PHCoreV020_CI_BUILD
    class EncounterReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct Encounter resource from Encounter read interaction'
      description 'A server SHALL support the Encounter read interaction.'

      id :ph_core_v020_ci_build_encounter_read_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def resource_type
        'Encounter'
      end

      def scratch_resources
        scratch[:encounter_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
