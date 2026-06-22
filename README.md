# PH Core Test Kit

An [Inferno](https://inferno-framework.github.io/) test kit for testing FHIR server conformance to the [PH Core Implementation Guide](https://fhir.doh.gov.ph/phcore/ImplementationGuide/fhir.ph.core).

- **IG package ID:** `fhir.ph.core`
- **IG version:** `0.2.0-ci-build`
- **CapabilityStatement:** `https://fhir.doh.gov.ph/phcore/CapabilityStatement/ph-core-server`
- **Terminology server:** `https://tx.fhir.org/r4`

## What is tested

The suite is auto-generated from the PH Core IG using the [InfernoSuiteGenerator](https://github.com/hl7au/inferno_suite_generator) gem. It covers the following resource groups:

| Resource group | Notes |
|---|---|
| Patient | First-class profile with search tests |
| Condition | |
| Encounter | |
| Observation | |
| Organization | |
| Practitioner | |
| PractitionerRole | |

Resources skipped by configuration: `Medication`, `DiagnosticReport`, `Bundle`, `Parameters`.

## Quick start

### Prerequisites

- Docker and Docker Compose

### Running the stack

```sh
make setup    # pull images, build, run DB migrations
make run      # build + start all services (available at http://localhost)
make tests    # run the RSpec suite
make stop     # stop containers
make down     # stop and remove containers
```

Other useful targets:

```sh
make generate            # regenerate tests from the IG (inside Docker)
MODE=local make generate # regenerate tests using local Ruby
make migrate             # run DB migrations only
make rubocop             # lint via RuboCop
make rubocop-fix         # lint and auto-fix
make clean_generated     # wipe generated tests (restores from git)
make start_from_zero     # stop + down + setup + run
make full_develop_restart  # stop + down + generate + setup + run
```

## Suite inputs

| Input | Required | Default | Description |
|---|---|---|---|
| `url` | Yes | `https://hapi.fhir.org/baseR4` | FHIR endpoint URL |
| `smart_credentials` | No | — | OAuth credentials |
| `header_name` / `header_value` | No | — | Optional HTTP header to pass with every request |

## Configuration

`config.json` is the single source of truth for suite configuration. Key sections:

- **`ig`** — IG package ID, name, version, and CapabilityStatement URLs
- **`suite`** — display title, terminology server, sidebar links
- **`constants`** — default values pre-filled in the Inferno UI
- **`configs.profiles`** — per-profile options (e.g. `first_class_profile`)
- **`configs.resources`** — per-resource options (e.g. `"skip": true`)

## Project structure

```
bin/
  wizard            # interactive configuration wizard (Ruby / Thor)
  setup.sh          # runs the wizard inside a Docker container
config/
  database.yml      # DB connection config
  nginx.conf        # nginx reverse-proxy config
  puma.rb           # Puma web server config
config.json         # suite configuration (IG, constants, profiles)
env/
  app               # app environment variables
  aidbox            # Aidbox-specific environment variables
lib/
  ph_core_test_kit.rb         # main kit entry point
  ph_core_test_kit/
    version.rb                # gem version
    igs/                      # IG .tgz packages
    generated/v0.2.0-ci-build/ # auto-generated tests (do not edit)
spec/               # RSpec test suite
compose.yaml        # default Docker Compose stack
compose.aidbox.yaml # Aidbox variant
Dockerfile
Makefile            # common dev tasks
Procfile            # process definitions for foreman/overmind
Rakefile            # Rake task definitions
worker.rb           # background worker entry point
```

## Aidbox variant

Set your Aidbox license in `.env`:

```
AIDBOX_LICENSE=your-license-key
```

Then pass `MODE=aidbox` to any make target:

```sh
MODE=aidbox make run
```

## Regenerating tests

If you update the IG package or `config.json`, regenerate the test suite:

1. Place the updated IG package at `lib/ph_core_test_kit/igs/<version>.tgz`
2. Run `make generate` (or `MODE=local make generate` to run without Docker)

## Links

- [Report an issue](https://github.com/projkov/ph-inferno-test-kit/issues)
- [Source code](https://github.com/projkov/ph-inferno-test-kit)
- [PH Core Implementation Guide](https://fhir.doh.gov.ph/phcore/ImplementationGuide/fhir.ph.core)

## Based on

This kit was scaffolded from the [inferno-suite-template](https://github.com/beda-software/inferno-suite-template) — a starter template for building Inferno test kits against any FHIR Implementation Guide. The template ships with a configuration wizard and a code-generation pipeline powered by the [InfernoSuiteGenerator](https://github.com/hl7au/inferno_suite_generator) gem.

## License

[Apache-2.0](LICENSE)
