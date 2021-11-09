# F5_Solutions_4_Public_Cloud


Requirements:

1) Ansible
2) aws cli
3) kubectl
4) eksctl

eksctl: 
needed for creation and management of the EKS Cluster.
installation steps: `https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html`

1) launch `install_requirements.sh` for installing the Ansible Collections that will/might be needed.
2) launch `run_project.sh`
   1) launch an ansible playbook to create an EKS cluster in AWS (can last up to 15/20 minutes.)
   2) launch configure_k8s_Cluster -> deployment of all the pods and services into the EKS cluster.

Variables which must be set into run_project.sh:

1) profile_aws: ID of the AWS profile to use and defined into the file ~/.aws/credentials
2) region: AWS Region where you want to deploy the infra
3) cidr_eks_vpc: the CIDR block you want to be created and used by the EKS Cluster
4) owner and email: strings that will be used as tags to identify all the objects created into AWS for you
5) JWT: The JWT subscription token you have received with your NGINX+ license


