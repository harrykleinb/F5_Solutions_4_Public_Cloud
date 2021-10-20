#!/bin/bash

ansible-galaxy install -r requirements.yml --force-with-deps

ansible-playbook -e profile_aws=harry -e region=eu-west-3 -e owner=harryk Create_Infra_AWS.yml

