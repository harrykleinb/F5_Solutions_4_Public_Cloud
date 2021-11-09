#!/bin/bash

ansible-playbook -vvv -e profile_aws="643019619955_Users" -e region="eu-west-2" -e owner="harryk" ./Ansible_Playbooks/Infra_AWS.yml --tags create

./k8s/Configure_k8s_Cluster.sh

