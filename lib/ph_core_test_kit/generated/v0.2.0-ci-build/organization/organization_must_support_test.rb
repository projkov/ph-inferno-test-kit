# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module PHCoreTestKit
  module PHCoreV020_CI_BUILD
    class OrganizationMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the Organization resources returned'
      description %(
        PH Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the PH Core Server Capability
        Statement. This test will look through the Organization resources
        found previously for the following must support elements:

        * Organization.active
        * Organization.address
        * Organization.contact.address
        * Organization.contact.purpose
        * Organization.contact.purpose.coding
        * Organization.contact.purpose.text
        * Organization.identifier:HcpnCode
        * Organization.identifier:NhfrCode
        * Organization.identifier:PAN
        * Organization.identifier:PEN
        * Organization.name
        * Organization.telecom
        * Organization.type
        * Organization.type.coding
        * Organization.type.text
      )

      id :ph_core_v020_ci_build_organization_must_support_test

      def resource_type
        'Organization'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(
                                                                            File.join(__dir__,
                                                                                      'metadata.yml'), aliases: true
                                                                          ))
      end

      def scratch_resources
        scratch[:organization_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
