#!/bin/bash
. ./common_OSX.sh

if [ -z "$1" ]
then
    showStep "invocation format is: $0 {Cluster Name} "
    exit -1
fi

CLUSTER_NAME=$1
showStep "Retrieving Cluster configuration for $CLUSTER_NAME"
CLUSTER_RESPONSE=$(ibmcloud ks cluster-config $CLUSTER_NAME )
if [[ -z "$CLUSTER_RESPONSE" ]]; then
    showStep "retrieving cluster config failed. Aborting"
    exit -1
fi
showStep "CLUSTER RESPONSE is: '$CLUSTER_RESPONSE'" 
FAILED=$(echo "$CLUSTER_RESPONSE" | grep 'FAILED')
showStep "Checking to see if cluster-config succeeded. if following is empty, we're OK. FAILED='$FAILED'"
if [[ -z "$FAILED" ]]; then
    showStep "retrieving KUBECONFIG from cluster-config"
    export $(echo "$CLUSTER_RESPONSE" | grep 'KUBECONFIG' | awk '{print $2}')
else
    showStep "failed to retrieve cluster config for $CLUSTER_NAME. Aborting script"
    exit -1
fi
# KUBECONFIG=$(ibmcloud ks cluster-config $CLUSTER_NAME | grep 'KUBECONFIG' | awk '{print $2}')
echo "KUBECONFIG to export is $(echo "$CLUSTER_RESPONSE" | grep 'KUBECONFIG' | awk '{print $2}')"
echo $KUBECONFIG
