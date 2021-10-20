#!/bin/bash

ansible-galaxy install -r ./Ansible_Playbooks/requirements.yml --force-with-deps

ansible-playbook -e profile_aws="harry" -e region="eu-west-3" -e owner="harryk" ./Ansible_Playbooks/Create_Infra_AWS.yml --tags destroy

