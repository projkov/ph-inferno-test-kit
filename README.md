# WIP: Inferno Suite Template

A starter template for building [Inferno](https://inferno-framework.github.io/) test kits against a FHIR Implementation Guide. It ships with a configuration wizard that replaces all placeholders in one go, so you can go from clone to a working test kit in minutes.

## Quick start

### Option 1 — Bootstrap script (recommended)

Download [create.sh](create.sh) once, then run it from any directory:

```sh
curl -fsSL https://raw.githubusercontent.com/beda-software/inferno-suite-template/main/create.sh -o create.sh
chmod +x create.sh
./create.sh my-test-kit          # clones template, strips history, runs wizard
./create.sh my-test-kit --no-wizard  # skip the wizard
```

The script clones the template, reinitialises git, and (optionally) launches the configuration wizard. It auto-detects Docker or a local Ruby installation for the wizard step.

### Option 2 — Manual clone + Docker wizard

```sh
git clone https://github.com/beda-software/inferno-suite-template my-test-kit
cd my-test-kit
./bin/setup.sh          # interactive wizard (requires Docker)
# ./bin/setup.sh --dry-run  # preview without writing files
```

### Option 3 — Manual clone + local Ruby wizard

```sh
git clone https://github.com/beda-software/inferno-suite-template my-test-kit
cd my-test-kit
gem install thor
ruby bin/wizard          # interactive wizard
# ruby bin/wizard --dry-run
```

The wizard walks through five sections and then updates all files in one step:

| Section | What it configures |
|---|---|
| Implementation Guide | Package ID, name, version, URLs, CapabilityStatement URL |
| Kit identity | Gem name (snake_case) and Ruby module name (CamelCase) |
| Author & gem metadata | Author, email, summary, GitHub URL |
| Suite | Display title, terminology server URL |
| Default constants | Pre-filled FHIR server URL, patient/encounter/practitioner IDs |

After the wizard finishes:

1. Place your IG package at `lib/<kit_name>/igs/<version>.tgz`
2. Run `make generate` to generate tests from the IG (or `MODE=local make generate` to run without Docker)
3. Run `make run` to start the stack

## Running the stack

```sh
make setup    # pull images, build, run DB migrations
make run      # build + start all services
make tests    # run the RSpec suite
make stop     # stop containers
make down     # stop and remove containers
```

Other useful targets:

```sh
make migrate             # run DB migrations only
make rubocop             # lint via RuboCop
make rubocop-fix         # lint and auto-fix
make clean_generated     # wipe generated tests (restores from git)
make start_from_zero     # stop + down + setup + run
make full_develop_restart  # stop + down + generate + setup + run
```

### Aidbox variant

Set your Aidbox license in `.env`:

```
AIDBOX_LICENSE=your-license-key
```

Then pass `MODE=aidbox` to any make target:

```sh
MODE=aidbox make run
```

## Configuration

`config.json` is the single source of truth for suite configuration. Key sections:

- **`ig`** — IG package metadata and CapabilityStatement URLs
- **`suite`** — display title, terminology server, outer groups, sidebar links
- **`constants`** — default values pre-filled in the Inferno UI
- **`configs.profiles`** — per-profile options (filters, search params, must-support exclusions)
- **`configs.resources`** — per-resource options (e.g. `"skip": true`)

See [TEMPLATE_PLACEHOLDERS.txt](TEMPLATE_PLACEHOLDERS.txt) for a full list of every placeholder and which files it appears in.

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
  my_test_kit.rb    # main kit entry point
  my_test_kit/
    version.rb      # gem version
    igs/            # place your IG .tgz packages here
    generated/      # auto-generated tests (do not edit)
spec/               # RSpec test suite
.env                # local secrets (e.g. AIDBOX_LICENSE)
Makefile            # common dev tasks
Procfile            # process definitions for foreman/overmind
Rakefile            # Rake task definitions
compose.yaml        # default Docker Compose stack
compose.aidbox.yaml # Aidbox variant
Dockerfile
worker.rb           # background worker entry point
```

## License

See [LICENSE](LICENSE).
