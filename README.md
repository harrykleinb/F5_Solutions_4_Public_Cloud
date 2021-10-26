# F5_Solutions_4_Public_Cloud


Requirements:

Ansible
aws cli, kubectl, and eksctl

eksctl: 
needed for creation and management of the EKS Cluster.
installation steps: https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html

1) run install_requirements.sh
2) run create_infra.sh -> create VPC, 
3) run create_eks.sh -> deployment of the EKS Cluster can last up to 15 minutes. 
4) Continue the next step when the EKS cluster is active (check into the AWS Management Console)
5) run run_project.sh
6) 


