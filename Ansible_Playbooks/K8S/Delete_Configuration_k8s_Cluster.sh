#!/bin/bash

#see https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-manifests/

#Delete the nginx-ingress namespace to uninstall the Ingress controller along with all the auxiliary resources that were created:
kubectl delete namespace nginx-ingress

#Delete namespace arcadia
kubectl delete namespace arcadia

#Delete the ClusterRole and ClusterRoleBinding:
kubectl delete clusterrole nginx-ingress
kubectl delete clusterrolebinding nginx-ingress

#Delete the Custom Resource Definitions:
#Note: This step will also remove all associated Custom Resources.
kubectl delete -f ./K8S/common/crds/




