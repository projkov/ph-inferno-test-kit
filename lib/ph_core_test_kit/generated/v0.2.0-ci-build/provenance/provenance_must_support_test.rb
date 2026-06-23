# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module PHCoreTestKit
  module PHCoreV020_CI_BUILD
    class ProvenanceMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the Provenance resources returned'
      description %(
        PH Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the PH Core Server Capability
        Statement. This test will look through the Provenance resources
        found previously for the following must support elements:

        * Provenance.activity
        * Provenance.activity.coding
        * Provenance.activity.text
        * Provenance.agent.onBehalfOf
        * Provenance.agent.role
        * Provenance.agent.role.coding
        * Provenance.agent.role.text
        * Provenance.agent.type
        * Provenance.agent.who
        * Provenance.agent:ProvenanceAuthor
        * Provenance.agent:ProvenanceAuthor.onBehalfOf
        * Provenance.agent:ProvenanceAuthor.role
        * Provenance.agent:ProvenanceAuthor.role.coding
        * Provenance.agent:ProvenanceAuthor.role.text
        * Provenance.agent:ProvenanceAuthor.type
        * Provenance.agent:ProvenanceAuthor.who
        * Provenance.agent:ProvenanceTransmitter
        * Provenance.agent:ProvenanceTransmitter.onBehalfOf
        * Provenance.agent:ProvenanceTransmitter.role
        * Provenance.agent:ProvenanceTransmitter.role.coding
        * Provenance.agent:ProvenanceTransmitter.role.text
        * Provenance.agent:ProvenanceTransmitter.type
        * Provenance.agent:ProvenanceTransmitter.who
        * Provenance.reason
        * Provenance.reason.coding
        * Provenance.reason.text
        * Provenance.recorded
        * Provenance.target
        * Provenance.target.reference
      )

      id :ph_core_v020_ci_build_provenance_must_support_test

      def resource_type
        'Provenance'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(
                                                                            File.join(__dir__,
                                                                                      'metadata.yml'), aliases: true
                                                                          ))
      end

      def scratch_resources
        scratch[:provenance_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
