#!/usr/bin/make -f

NAME=M8s
PROFILE=standard
PASS=password

APP=$(shell pwd)/web

init:
	composer install --prefer-dist --no-progress

install: init
	cd $(APP) ; ../vendor/bin/drush site-install -y --site-name=$(NAME) --account-pass=$(PASS) $(PROFILE)
	chown -R www-data:www-data $(APP)
