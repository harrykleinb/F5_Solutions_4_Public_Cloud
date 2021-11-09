#!/bin/bash

# See explanations on https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-manifests/

echo -e "\nCreate a namespace and a service account for the Ingress controller"
kubectl apply -f ./k8s/common/ns-and-sa.yaml

echo -e "\nCreate a cluster role and cluster role binding for the service account"
kubectl apply -f ./k8s/rbac/rbac.yaml

echo -e "\nCreate the App Protect role and role binding"
kubectl apply -f ./k8s/rbac/ap-rbac.yaml

echo -e "\nCreate a secret with a TLS certificate and a key for the default server in NGINX"
kubectl apply -f ./k8s/common/default-server-secret.yaml

echo -e "\nCreate a config map for customizing NGINX configuration"
kubectl apply -f ./k8s/common/nginx-config.yaml

echo -e \n"Create an IngressClass resource"
kubectl apply -f ./k8s/common/ingress-class.yaml

echo -e "\nCreate custom resource definitions for VirtualServer and VirtualServerRoute, TransportServer and Policy resources"
kubectl apply -f ./k8s/common/crds/k8s.nginx.org_virtualservers.yaml
kubectl apply -f ./k8s/common/crds/k8s.nginx.org_virtualserverroutes.yaml
kubectl apply -f ./k8s/common/crds/k8s.nginx.org_transportservers.yaml
kubectl apply -f ./k8s/common/crds/k8s.nginx.org_policies.yaml

echo -e "\nCreate a custom resource definition for GlobalConfiguration resource. Needed for TCP/UDP LB in NIC"
kubectl apply -f ./k8s/common/crds/k8s.nginx.org_globalconfigurations.yaml

echo -e "\nCreate a custom resource definition for APPolicy, APLogConf and APUserSig. Needed for NAP."
kubectl apply -f ./k8s/common/crds/appprotect.f5.com_aplogconfs.yaml
kubectl apply -f ./k8s/common/crds/appprotect.f5.com_appolicies.yaml
kubectl apply -f ./k8s/common/crds/appprotect.f5.com_apusersigs.yaml


echo -e "\nCreate a docker-registry secret on the cluster using the JWT subscription token"
#kubectl create secret docker-registry regcred --docker-server=private-registry.nginx.com --docker-username=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InRyaWFsIn0.eyJpc3MiOiJuZ2lueCBpc3N1ZXIiLCJpYXQiOjE2MzU0MzIzNjMsImp0aSI6Ijk5Iiwic3ViIjoiSTAwMDExNjY3MiIsImV4cCI6MTY1MDk4NDM2M30.G3wcBcoSIRyiyYs1VZxXrWPz0_Aex9XVwneY1t_2WpzY3UI8c0sjBD56YjojzR_FP7AO4Fo3ERpVpY0X8DERapMtS46ysDzrMqjTW4t2WdHnWARons5X5Gv6HsBnLeTnn002DciAB4tvbbB797DVOMklgcqNLE6D6cEC6fPffxOnM_6K-1xZkdciGehNcNM_Ll-JBloE-wq-1RoQvW6MxRd6hBPYYUdFkGYqdETGncAHnIEC-DIjdzimivkTUNCSKfrb4OP0hHKnRQvIbOZlsHydPoFHHsraRD2e0VdUfdA2tLuP-iTZCfFi8f9TrLQwKz0_eIIdxFNWkdBYZHSHiGMyB0DfelhDolF62sLrX88OMkbmBx8C6roVwfF5KN6Y-_Zm25KEer7_LaQSfWx0brVxYXyJrwP-TwddsOp_XWzpy43a68t4i8ZfFu0AxceXVbsMLXMmvczh51DQqwBQj0rTzUMoTMuON_Xz3LJzFIRFFeHo5gfrGrRCn6lpmAyU --docker-password=none -n nginx-ingress
kubectl create secret docker-registry regcred --docker-server=private-registry.nginx.com --docker-username=$1 --docker-password=none -n nginx-ingress
kubectl get secret regcred --output=yaml -n nginx-ingress


echo -e "\nDeploy the NGINX+ Ingress Controller"
kubectl apply -f ./k8s/deployment/nginx-plus-ingress.yaml

#echo -e "\nCheck that the Ingress Controller is Running"
#kubectl get pods --namespace=nginx-ingress

echo -e "\nSetup AWS ELB to Get Access to the Ingress Controller"
kubectl apply -f ./k8s/service/loadbalancer-aws-elb.yaml

echo -e "\nGet hostname of the AWS ELB"
#Public IPs of ELB are dynamic so we must use hostname to connect to the Ingress Controller
#kubectl describe svc nginx-ingress --namespace=nginx-ingress
#Only the line with the hostname :
#kubectl get service nginx-ingress -n nginx-ingress |  awk {'print $1" " $2 " " $4 " " $5'} | column -t
#That hostname must be used into the manifest arcadia-ingress.yaml
#Use the following method to use the hostname as a variable into the deployment:
#https://stackoverflow.com/questions/48296082/how-to-set-dynamic-values-with-kubernetes-yaml-file

HOSTNAME_ELB=$(kubectl get service nginx-ingress -n nginx-ingress -o json | jq .status.loadBalancer.ingress[].hostname)

echo -e "Hostname of the AWS ELB is: $HOSTNAME_ELB"




echo -e "\nCreate a namespace and a service account for arcadia"
kubectl apply -f ./k8s/arcadia/ns-and-sa.yaml

echo -e "\nDeploy Arcadia:\n"
kubectl apply -f ./k8s/arcadia/arcadia-frontend.yaml
kubectl apply -f ./k8s/arcadia/arcadia-db.yaml
kubectl apply -f ./k8s/arcadia/arcadia-login.yaml
kubectl apply -f ./k8s/arcadia/arcadia-stock_transaction.yaml
kubectl apply -f ./k8s/arcadia/arcadia-stocks.yaml
kubectl apply -f ./k8s/arcadia/arcadia-users.yaml

echo -e "\nDeploy Arcadia Ingress based on hostname of the AWS ELB"
template=`cat "./k8s/arcadia/arcadia-ingress.yaml.template" | sed "s/{{hostname}}/$HOSTNAME_ELB/g"`
echo "$template" | kubectl apply -f -


