#!/usr/bin/make -f

SITE_NAME ?= M8s
PROFILE=standard
ADMIN_ACCOUNT_USERNAME ?= admin
ADMIN_ACCOUNT_PASSWORD ?= password

APP=$(shell pwd)/app

init:
	composer install --prefer-dist --no-progress

login:
	cd $(APP) ; ../vendor/bin/drush --uri='${SITE_URI}' uli

install-coder:
	composer require drupal/coder
	./vendor/bin/phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer

lint: install-coder
	./vendor/bin/phpcs --standard=phpcs.xml

phpunit-test:
	./vendor/bin/phpunit

unit-tests: lint phpunit-test

install: init
	echo "Installing drupal site $(SITE_NAME) at $(SITE_URI)"
	cd $(APP) ; ../vendor/bin/drush site-install -y --site-name=$(SITE_NAME) --account-name=$(ADMIN_ACCOUNT_USERNAME) --account-pass=$(ADMIN_ACCOUNT_PASSWORD) --db-url=mysql://drupal:drupal@127.0.0.1:3306/local $(PROFILE)
	chown -R www-data:www-data $(APP)
