#!/bin/bash

# See explanations on https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-manifests/

#Create a namespace and a service account for the Ingress controller
kubectl apply -f ./K8S/common/ns-and-sa.yaml

#Create a cluster role and cluster role binding for the service account
kubectl apply -f ./K8S/rbac/rbac.yaml

#Create the App Protect role and role binding
kubectl apply -f ./K8S/rbac/ap-rbac.yaml

#Create a secret with a TLS certificate and a key for the default server in NGINX
kubectl apply -f ./K8S/common/default-server-secret.yaml

#Create a config map for customizing NGINX configuration
kubectl apply -f ./K8S/common/nginx-config.yaml

#Create an IngressClass resource
kubectl apply -f ./K8S/common/ingress-class.yaml

#Create custom resource definitions for VirtualServer and VirtualServerRoute, TransportServer and Policy resources
kubectl apply -f ./K8S/common/crds/k8s.nginx.org_virtualservers.yaml
kubectl apply -f ./K8S/common/crds/k8s.nginx.org_virtualserverroutes.yaml
kubectl apply -f ./K8S/common/crds/k8s.nginx.org_transportservers.yaml
kubectl apply -f ./K8S/common/crds/k8s.nginx.org_policies.yaml

#Create a custom resource definition for GlobalConfiguration resource. Needed for TCP/UDP LB in NIC
kubectl apply -f ./K8S/common/crds/k8s.nginx.org_globalconfigurations.yaml

#Create a custom resource definition for APPolicy, APLogConf and APUserSig. Needed for NAP.
kubectl apply -f ./K8S/common/crds/appprotect.f5.com_aplogconfs.yaml
kubectl apply -f ./K8S/common/crds/appprotect.f5.com_appolicies.yaml
kubectl apply -f ./K8S/common/crds/appprotect.f5.com_apusersigs.yaml


#Create a docker-registry secret on the cluster using the JWT subscription token
kubectl create secret docker-registry regcred --docker-server=private-registry.nginx.com --docker-username=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InRyaWFsIn0.eyJpc3MiOiJuZ2lueCBpc3N1ZXIiLCJpYXQiOjE2MzU0MzIzNjMsImp0aSI6Ijk5Iiwic3ViIjoiSTAwMDExNjY3MiIsImV4cCI6MTY1MDk4NDM2M30.G3wcBcoSIRyiyYs1VZxXrWPz0_Aex9XVwneY1t_2WpzY3UI8c0sjBD56YjojzR_FP7AO4Fo3ERpVpY0X8DERapMtS46ysDzrMqjTW4t2WdHnWARons5X5Gv6HsBnLeTnn002DciAB4tvbbB797DVOMklgcqNLE6D6cEC6fPffxOnM_6K-1xZkdciGehNcNM_Ll-JBloE-wq-1RoQvW6MxRd6hBPYYUdFkGYqdETGncAHnIEC-DIjdzimivkTUNCSKfrb4OP0hHKnRQvIbOZlsHydPoFHHsraRD2e0VdUfdA2tLuP-iTZCfFi8f9TrLQwKz0_eIIdxFNWkdBYZHSHiGMyB0DfelhDolF62sLrX88OMkbmBx8C6roVwfF5KN6Y-_Zm25KEer7_LaQSfWx0brVxYXyJrwP-TwddsOp_XWzpy43a68t4i8ZfFu0AxceXVbsMLXMmvczh51DQqwBQj0rTzUMoTMuON_Xz3LJzFIRFFeHo5gfrGrRCn6lpmAyU --docker-password=none -n nginx-ingress
kubectl get secret regcred --output=yaml -n nginx-ingress


#Deploy the Ingress Controller
kubectl apply -f ./K8S/deployment/nginx-plus-ingress.yaml

#Check that the Ingress Controller is Running
kubectl get pods --namespace=nginx-ingress

#Get Access to the Ingress Controller via AWS ELB (Classic LB)
kubectl apply -f ./K8S/service/loadbalancer-aws-elb.yaml

#Get hostname of AWS ELB
#Public IPs are dynamic so we must use hostname to connect to the NIC
#kubectl describe svc nginx-ingress --namespace=nginx-ingress
#get the hostname from the field LoadBalancer Ingress


#Create a namespace and a service account for arcadia
kubectl apply -f ./K8S/arcadia/ns-and-sa.yaml

#PAR-ML-00011143:Ansible_Playbooks kleinbourg$ kubectl apply -f ./K8S/arcadia/arcadia-frontend.yaml
#deployment.apps/arcadia-frontend created
#service/arcadia-frontend created
#PAR-ML-00011143:Ansible_Playbooks kleinbourg$ kubectl apply -f ./K8S/arcadia/arcadia-db.yaml
#deployment.apps/arcadia-db created
#service/arcadia-db created
#PAR-ML-00011143:Ansible_Playbooks kleinbourg$ kubectl apply -f ./K8S/arcadia/arcadia-login.yaml
#deployment.apps/arcadia-login created
#service/arcadia-login created
#PAR-ML-00011143:Ansible_Playbooks kleinbourg$ kubectl apply -f ./K8S/arcadia/arcadia-stock_transaction.yaml
#deployment.apps/arcadia-stock-transaction created
#service/arcadia-stock-transaction created
#PAR-ML-00011143:Ansible_Playbooks kleinbourg$ kubectl apply -f ./K8S/arcadia/arcadia-stocks.yaml
#deployment.apps/arcadia-stocks created
#service/arcadia-stocks created
#PAR-ML-00011143:Ansible_Playbooks kleinbourg$ kubectl apply -f ./K8S/arcadia/arcadia-users.yaml
#deployment.apps/arcadia-users created
#service/arcadia-users created
#PAR-ML-00011143:Ansible_Playbooks kleinbourg$ kubectl apply -f ./K8S/arcadia/arcadia-ingress.yaml
#secret/arcadia-wildcard created
#virtualserver.k8s.nginx.org/arcadia created
#PAR-ML-00011143:Ansible_Playbooks kleinbourg$


