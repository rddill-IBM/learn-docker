#!/bin/bash
. scripts/common_OSX.sh
getCurrent
ENV_FILE="./controller/env.json"
APIKEYFILE="$1"
REGION=$(cat ${ENV_FILE} | jq -r .cf_region )
CF_API=$(cat ${ENV_FILE} | jq -r .cf_api )
CF_ORG=$(cat ${ENV_FILE} | jq -r .cf_org )
CF_SPACE=$(cat ${ENV_FILE} | jq -r .cf_space )
showStep "Attempting IBMCloud Login with 'ibmcloud login --apikey @$APIKEYFILE -r $REGION'"
ibmcloud login --apikey @$APIKEYFILE -r $REGION
RC=$?
if [[ $RC != 0 ]]; then
    showStep "IBMCloud Login completed with $RC"
fi

showStep "Attempting IBMCloud target with 'ibmcloud target --cf-api $CF_API  -o $CF_ORG -s $CF_SPACE'"
ibmcloud target --cf-api $CF_API -o $CF_ORG -s $CF_SPACE

RC=$?
if [[ $RC != 0 ]]; then
    showStep "IBMCloud Login target with $RC"
fi
exit $RC
