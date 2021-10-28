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

