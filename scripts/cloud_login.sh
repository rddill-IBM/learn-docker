#!/bin/bash
. ./common_OSX.sh
getCurrent

APIKEYFILE="../$1"
REGION=$2
showStep "Attempting IBMCloud Login with 'ibmcloud login --apikey @$APIKEYFILE -r $REGION'"
ibmcloud login --apikey @$APIKEYFILE -r $REGION

RC=$?
if [[ $RC != 0 ]]; then
    showStep "IBMCloud Login completed with $RC"
    showStep "IBMCloud Login attempted with 'ibmcloud login --apikey @$APIKEYFILE -r $REGION'"
fi
exit $RC
