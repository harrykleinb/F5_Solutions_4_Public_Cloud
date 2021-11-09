# F5_Solutions_4_Public_Cloud


Requirements:

Ansible
aws cli, kubectl, and eksctl

eksctl: 
needed for creation and management of the EKS Cluster.
installation steps: https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html

1) launch install_requirements.sh
2) launch run_project.sh
   1) create EKS in AWS with Ansible (can last up to 15/20 minutes.)
   2) run configure_k8s_Cluster -> deployment of all the pods and services into the EKS cluster.




