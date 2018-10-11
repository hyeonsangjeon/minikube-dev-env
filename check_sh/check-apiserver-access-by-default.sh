#!/bin/bash 
# For v1.8.x default policy, this 'curl' results in '403 Forbidden' 
APISERVER=$(kubectl config view | grep server | cut -f 2- -d ":" | tr -d " ") 
# Retrieve 'default' account's TOKEN in 'default' namespace 
TOKEN="$(kubectl get secret $(kubectl get secrets | grep default | cut -f1 -d ' ') -o jsonpath='{$.data.token}' | base64 --decode)" 
 curl -D - --insecure --header "Authorization: Bearer $TOKEN" $APISERVER/api/v1/namespaces/default/services
# curl -D - --insecure --header "Authorization: Bearer $TOKEN" $APISERVER/api/v1
#curl -D - --insecure --header "Authorization: Bearer $TOKEN" $APISERVER/api/v1/namespaces/dhpns/pods
