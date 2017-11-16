#!/usr/bin/make -f

SITE_NAME ?= M8s
PROFILE=standard
PASS=password

APP=$(shell pwd)/app

init:
	composer install --prefer-dist --no-progress

install: init
	cd $(APP) ; ../vendor/bin/drush site-install -y --site-name=$(SITE_NAME) --account-pass=$(PASS) --db-url=mysql://drupal:drupal@127.0.0.1:3306/local $(PROFILE)
	chown -R www-data:www-data $(APP)
