#!/bin/bash
# $1 is kind (User, Group, ServiceAccount)
# $2 is name ("system:nodes", etc)
# $3 is namespace (optional, only applies to kind=ServiceAccount)
function getRoles() {
    local kind="${1}"
    local name="${2}"
    local namespace="${3:-}"

    kubectl get clusterrolebinding -o json | jq -r "
        .items[]
        |
        select(
            .subjects[]?
            |
            select(
                .kind == \"${kind}\"
                and
                .name == \"${name}\"
                and
                (if .namespace then .namespace else \"\" end) == \"${namespace}\"
            )
        )
        |
        (.metadata.name + \" \" + .roleRef.kind + \"/\" + .roleRef.name)
    "
}

if [ $# -lt 2 ]; then
    echo "Usage: $0 kind name {namespace}"
    exit -1
fi


echo "* Query: "
echo " - kind: $1"
echo " - name: $2"
echo " - namespace: $3"
echo "* Result: "
echo "[ClusterRolebinding] [Clusterrole.kind/Clusterrole.name]"

getRoles $1 $2 $3




