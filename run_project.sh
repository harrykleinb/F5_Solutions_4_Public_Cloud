#!/bin/bash

ansible-playbook -vvv -e profile_aws="643019619955_Users" -e region="eu-west-2" -e cidr_eks_vpc="10.42.0.0/16" -e owner="kleinbourg" -e mail="h.kleinbourg@f5.com" ./Ansible_Playbooks/Infra_AWS.yml --tags create


# var_jwt is the JWT token you've received with your nginx+ license. It will be used to deploy nginx+ from the nginx repo.

var_jwt='eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InRyaWFsIn0.eyJpc3MiOiJuZ2lueCBpc3N1ZXIiLCJpYXQiOjE2MzU0MzIzNjMsImp0aSI6Ijk5Iiwic3ViIjoiSTAwMDExNjY3MiIsImV4cCI6MTY1MDk4NDM2M30.G3wcBcoSIRyiyYs1VZxXrWPz0_Aex9XVwneY1t_2WpzY3UI8c0sjBD56YjojzR_FP7AO4Fo3ERpVpY0X8DERapMtS46ysDzrMqjTW4t2WdHnWARons5X5Gv6HsBnLeTnn002DciAB4tvbbB797DVOMklgcqNLE6D6cEC6fPffxOnM_6K-1xZkdciGehNcNM_Ll-JBloE-wq-1RoQvW6MxRd6hBPYYUdFkGYqdETGncAHnIEC-DIjdzimivkTUNCSKfrb4OP0hHKnRQvIbOZlsHydPoFHHsraRD2e0VdUfdA2tLuP-iTZCfFi8f9TrLQwKz0_eIIdxFNWkdBYZHSHiGMyB0DfelhDolF62sLrX88OMkbmBx8C6roVwfF5KN6Y-_Zm25KEer7_LaQSfWx0brVxYXyJrwP-TwddsOp_XWzpy43a68t4i8ZfFu0AxceXVbsMLXMmvczh51DQqwBQj0rTzUMoTMuON_Xz3LJzFIRFFeHo5gfrGrRCn6lpmAyU'

./k8s/Configure_k8s_Cluster.sh $var_jwt

