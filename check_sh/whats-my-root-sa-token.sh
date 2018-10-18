#!/bin/bash
# By modified RBAC policy, this 'curl' results in '200 OK'
kubectl get secret -nkube-system $(kubectl get secrets -nkube-system | grep root-sa | cut -f1 -d ' ') -o jsonpath='{$.data.token}' | base64 --decode