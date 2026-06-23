MODE ?= default
ifeq ($(MODE), default)
compose = docker compose
else ifeq ($(MODE), aidbox)
compose = docker compose -f compose.aidbox.yaml
endif
inferno = run inferno
rm_generated = rm -rf lib/ph_core_test_kit/generated/
ber_generate = bundle exec rake ph_core_test_kit:generate
lint_generated = rubocop -A lib/ph_core_test_kit/
ig_url = https://build.fhir.org/ig/UP-Manila-SILab/ph-core/package.tgz
ig_filename = 0.2.0-ci-build.tgz

.PHONY: setup generate summary new_release tests run pull build up stop down rubocop migrate clean_generated ig_download uploadfig_generate_local

setup: pull build migrate

ig_download:
	if [ "$(MODE)" = "local" ]; then \
		curl -fsSL -o /tmp/$(ig_filename) $(ig_url) && \
		cp /tmp/$(ig_filename) resources/ig/$(ig_filename) && \
		cp /tmp/$(ig_filename) lib/ph_core_test_kit/igs/$(ig_filename); \
	else \
		$(compose) run --rm ig-downloader; \
	fi

generate: ig_download
	if [ "$(MODE)" = "local" ]; then \
		$(ber_generate); \
		$(lint_generated); \
	else \
		$(compose) $(inferno) $(ber_generate); \
		$(compose) $(inferno) $(lint_generated); \
	fi

tests:
	$(compose) run -e APP_ENV=test inferno bundle exec rspec

run: build up

pull:
	$(compose) pull

build:
	$(compose) build

up:
	$(compose) up

stop:
	$(compose) stop

down:
	$(compose) down

rubocop:
	$(compose) $(inferno) rubocop

rubocop-fix:
	$(compose) $(inferno) rubocop -A

migrate:
	$(compose) $(inferno) bundle exec rake db:migrate

clean_generated:
	sudo $(rm_generated)
	git checkout lib/ph_core_test_kit/generated/

start_from_zero: stop down setup run

full_develop_restart: stop down generate setup run
