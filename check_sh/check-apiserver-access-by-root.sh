#!/bin/bash
# By modified RBAC policy, this 'curl' results in '200 OK'
APISERVER=$(kubectl config view | grep server | cut -f 2- -d ":" | tr -d " ")
# Retrieve 'root' account's TOKEN in 'kube-system' namespace
ROOTTOKEN="$(kubectl get secret -nkube-system $(kubectl get secrets -nkube-system | grep root-sa | cut -f1 -d ' ') -o jsonpath='{$.data.token}' | base64 --decode)"
curl -D - --insecure --header "Authorization: Bearer $ROOTTOKEN" $APISERVER/api/v1/namespaces/default/services

