# F5_Solutions_4_Public_Cloud


Requirements:

Ansible
aws cli, kubectl, and eksctl

eksctl: 
needed for creation and management of the EKS Cluster.
installation steps: https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html

1) launch install_requirements.sh
2) launch run_project.sh
   1) launch an ansible playbook to create an EKS cluster in AWS (can last up to 15/20 minutes.)
   2) launch configure_k8s_Cluster -> deployment of all the pods and services into the EKS cluster.

Three variables must be set into run_project.sh:
1) profile_aws: ID of the AWS profile to use and defined into the file ~/.aws/credentials
2) region: AWS Region where you want to deploy the infra
3) owner: a string that will be used as a tag to identify all the objects created into AWS for you



