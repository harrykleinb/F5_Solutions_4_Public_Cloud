#!/bin/bash

ansible-playbook -e profile_aws="643019619955_Users" -e region="eu-west-3" -e owner="harryk" ./Ansible_Playbooks/Infra_AWS.yml --tags create

