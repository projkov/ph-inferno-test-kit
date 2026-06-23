# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/read_test'

module PHCoreTestKit
  module PHCoreV020_CI_BUILD
    class PractitionerRoleReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct PractitionerRole resource from PractitionerRole read interaction'
      description 'A server SHALL support the PractitionerRole read interaction.'

      input :practitioner_role_ids,
            title: 'PractitionerRole IDs',
            description: 'Comma separated list of practitioner role IDs that in sum contain all MUST SUPPORT elements',
            default: '99605289',
            optional: true

      id :ph_core_v020_ci_build_practitioner_role_read_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def resource_type
        'PractitionerRole'
      end

      def scratch_resources
        scratch[:practitioner_role_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'PractitionerRole'))
      end
    end
  end
end
