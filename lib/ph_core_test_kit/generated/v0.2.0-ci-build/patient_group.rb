# frozen_string_literal: true

require 'inferno_suite_generator/core/ig_demodata'
require_relative 'patient/patient_id_search_test'
require_relative 'patient/patient_identifier_search_test'
require_relative 'patient/patient_name_search_test'
require_relative 'patient/patient_birthdate_search_test'
require_relative 'patient/patient_gender_search_test'
require_relative 'patient/patient_read_test'
require_relative 'patient/patient_validation_test'
require_relative 'patient/patient_must_support_test'

module PHCoreTestKit
  module PHCoreV020_CI_BUILD
    class PatientGroup < Inferno::TestGroup
      title 'Patient Tests'
      short_description 'Verify support for the server capabilities required by the PH Core Patient.'
      description %(
  # Background

The PH Core Patient sequence verifies that the system under test is
able to provide correct responses for Patient queries. These queries
must contain resources conforming to the PH Core Patient as
specified in the PH Core v0.2.0-ci-build Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* _id
* identifier

### Search Parameters
The first search uses the selected patient(s) from the prior launch sequence. Any subsequent searches will look for its parameter values from the results of the first search. For example, the `identifier` search in the patient sequence is performed by looking for an existing `Patient.identifier` from any of the resources returned in the `_id` search. If a value cannot be found this way, the search is skipped.

### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Patient resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Patient resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [PH Core Patient](https://fhir.doh.gov.ph/phcore/StructureDefinition/ph-core-patient). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

## Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.

      )

      id :ph_core_v020_ci_build_patient
      run_as_group

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(
                                                                            File.join(__dir__, 'patient',
                                                                                      'metadata.yml'), aliases: true
                                                                          ))
      end

      test from: :ph_core_v020_ci_build_patient__id_search_test
      test from: :ph_core_v020_ci_build_patient_identifier_search_test
      test from: :ph_core_v020_ci_build_patient_name_search_test
      test from: :ph_core_v020_ci_build_patient_birthdate_search_test
      test from: :ph_core_v020_ci_build_patient_gender_search_test
      test from: :ph_core_v020_ci_build_patient_read_test
      test from: :ph_core_v020_ci_build_patient_validation_test
      test from: :ph_core_v020_ci_build_patient_must_support_test
    end
  end
end
