#!/bin/bash
# set -x
###############################################################################
#
# Licensed Materials - Property of IBM
#
# (C) Copyright IBM Corp. 2023. All Rights Reserved.
#
# US Government Users Restricted Rights - Use, duplication or
# disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
#
###############################################################################

echo
echo "--------------------------------------------------------------"
echo

cp4baProjectName=$(oc project -q)

crname=$(oc get ICP4ACluster -o 'jsonpath={.items[0].metadata.name}' 2>/dev/null)
if [ "x$crname" != "x" ]; then
    echo "ICP4ACluster CR named $crname found"
    crtype=ICP4ACluster
else
    crname=$(oc get Content -o 'jsonpath={.items[0].metadata.name}' 2>/dev/null)
    if [ "x$crname" != "x" ]; then
	echo "Content CR named $crname found"
	crtype=Content
    else
	echo "No CR found, exiting"
	exit 1
    fi
fi

if oc get $crtype $crname -n $cp4baProjectName > /dev/null 2>&1; then
    echo "Custom Resource of type $crtype is applied"
    ICP4ADEPLOY=$(oc get $crtype $crname -n $cp4baProjectName -o 'jsonpath={.status.conditions}')
    echo $ICP4ADEPLOY  | jq -r '.[] | [.type, .status, .reason, .message]|@tsv' | sed 's/^/   /g'
else
    echo "No Custom Resource of type ICP4ACluster is applied"
    exit 1
fi

if oc get configmap ibm-common-services-status -n kube-public > /dev/null 2>&1; then
    IAMSTATUS=$(oc get configmap ibm-common-services-status -n kube-public -o 'jsonpath={.data.iamstatus}')
    CSIAMSTATUS=$(oc get configmap ibm-common-services-status -n kube-public -o 'jsonpath={.data.ibm-common-services-iamstatus}')
    CP4BAIAMSTATUS=$(oc get configmap ibm-common-services-status -n kube-public -o 'jsonpath={.data.ibm-cp4ba-iamstatus}')
    echo
    echo "Common Services Deployment Status:"
    echo "   IAM Status: $IAMSTATUS"
    echo "   CS IAM Status: $CSIAMSTATUS"
    echo "   CP4BA IAM Status: $CP4BAIAMSTATUS"
fi

if oc get zenservice iaf-zen-cpdservice  -n $cp4baProjectName  > /dev/null 2>&1; then
    ZENSERVICE=$(oc get zenservice iaf-zen-cpdservice  -n $cp4baProjectName -o 'jsonpath={.status.Progress} ({.status.ProgressMessage}) ')
    echo

    ZENSTATUS=$(oc get zenservice  iaf-zen-cpdservice  -n $cp4baProjectName -o 'jsonpath={.status.zenOperatorBuildNumber}:  {.status.zenStatus}')
    
    echo "ZenService Deployment Progress: $ZENSERVICE"
    echo "ZenStatus: $ZENSTATUS"
    
    ZENCONDITIONS=$(oc get zenservice iaf-zen-cpdservice  -n $cp4baProjectName -o 'jsonpath={.status.conditions}')
    echo $ZENCONDITIONS | jq -r '.[] | [.lastTransitionTime, .message]|@tsv' | sed 's/^/   /g'		    
fi

if oc get Foundation $crname -n $cp4baProjectName > /dev/null 2>&1; then
    FOUNDATION=$(oc get Foundation $crname -n $cp4baProjectName -o jsonpath={.status.conditions})
    echo
    echo "Foundation:"
    echo $FOUNDATION | jq -r '.[] | [.lastTransitionTime, .message]|@tsv' | sed 's/^/   /g'
fi

if oc get Cartridge icp4ba  -n $cp4baProjectName > /dev/null 2>&1; then
    CARTRIDGE=$(oc get Cartridge icp4ba  -n $cp4baProjectName -o jsonpath={.status.conditions})   
    echo
    echo "Cartridge:"
    echo $CARTRIDGE  | jq -r '.[] | [.lastTransitionTime, .message]|@tsv' | sed 's/^/   /g'
fi

if oc get InsightsEngine icp4adeploy  -n $cp4baProjectName > /dev/null 2>&1; then
    echo
    echo "InsightsEngine:"
    INSIGHTS=$(oc get InsightsEngine icp4adeploy  -n $cp4baProjectName -o 'jsonpath={.status.conditions}')
    echo $INSIGHTS  | jq -r '.[] | [.type, .status, .reason, .message]|@tsv' | sed 's/^/   /g' | sed 's/\\n/\n\t\t\t\t/g'
fi

if oc -n $cp4baProjectName get bts cp4ba-bts  -n $cp4baProjectName >/dev/null 2>&1; then
    BTSSTATUS=$(oc -n $cp4baProjectName get bts cp4ba-bts  -n $cp4baProjectName -o jsonpath={.status.serviceStatus})
    BTSMESSAGE=$(oc -n $cp4baProjectName get bts cp4ba-bts  -n $cp4baProjectName -o jsonpath={.status.reason})
    echo 
    echo "BTS: $BTSSTATUS  ($BTSMESSAGE)"
    
fi			     


if oc get elasticsearch iaf-system -n $cp4baProjectName > /dev/null 2>&1; then
    echo 
    echo "Elasticsearch:"
    ELASTICSEARCH=$(oc get elasticsearch iaf-system -n $cp4baProjectName -o 'jsonpath={.status.conditions}')
    echo $ELASTICSEARCH  | jq -r '.[] | [.type, .status, .reason, .message]|@tsv' | sed 's/^/   /g' | sed 's/\\n/\n\t\t\t\t/g'
fi

if [ "x$crtype" == "xICP4ACluster" ]; then
    CP4BAPREREQIAF=$(oc get $crtype $crname  -n $cp4baProjectName -o 'jsonpath={.status.components.prereq.iafStatus}')	     
    CP4BAPREREQIAM=$(oc get $crtype $crname  -n $cp4baProjectName -o 'jsonpath={.status.components.prereq.iamIntegrationStatus}')	     

    echo
    echo "CP4BA Prereq:"
    echo "   IAF: $CP4BAPREREQIAF"
    echo "   IAM Integration Status: $CP4BAPREREQIAM"

    CP4BARRCLUSTER=$(oc get $crtype $crname   -n $cp4baProjectName -o 'jsonpath={.status.components.resource-registry.rrCluster}')	     
    CP4BARRSERVICE=$(oc get $crtype $crname   -n $cp4baProjectName -o 'jsonpath={.status.components.resource-registry.rrService}')	     

    echo
    echo "Resource Registry:"
    echo "   Cluster: $CP4BARRCLUSTER"
    echo "   Service: $CP4BARRSERVICE"
fi

if oc get configmap ${crname}-aca-config  -n $cp4baProjectName >/dev/null 2>&1; then
    echo
    echo "ADP:"
    ACA_INIT_STATUS=$(oc get configmap ${crname}-aca-config  -n $cp4baProjectName -o jsonpath='{.data.ACA_INIT_STATUS}')
    echo "   Init-Status: $ACA_INIT_STATUS"
fi

echo
if [ $crtype == "ICP4ACluster" ]; then
    echo "Content:"
    if oc -n $cp4baProjectName get Content $crname -n $cp4baProjectName > /dev/null 2>&1; then
	CONTENT=$(oc -n $cp4baProjectName get Content $crname -n $cp4baProjectName -o 'jsonpath={.status.conditions}')
	echo $CONTENT  | jq -r '.[] | [.type, .status, .reason, .message]|@tsv' | sed 's/^/   /g' | sed 's/\\n/\n\t\t\t\t/g'
    else
	echo "\tnot yet deployed"
    fi
fi

echo 
echo "Initialization Status:"
if oc get Configmap ${crname}-initialization-config -n $cp4baProjectName > /dev/null 2>&1; then
    INIT=$(oc get Configmap ${crname}-initialization-config -n $cp4baProjectName -o 'jsonpath={.data}')
    echo $INIT | jq --tab   . | sed 's/"//g'
else
    echo "\tnot yet available"
fi


echo
if oc -n $cp4baProjectName get ProcessFederationServer icp4adeploy -n $cp4baProjectName > /dev/null 2>&1; then
    echo "Process Federation Server:"
    PFS=$(oc -n $cp4baProjectName get  ProcessFederationServer icp4adeploy -n $cp4baProjectName -o 'jsonpath={.status.conditions}')
    echo $PFS  | jq -r '.[] | [.lastTransitionTime, .type, .status, .reason, .message]|@tsv' | sed 's/^/   /g' | sed 's/\\n/\n\t\t\t\t/g'
fi


echo
if oc get icp4aautomationdecisionservices icp4adeploy -n $cp4baProjectName > /dev/null 2>&1; then
    echo "Automation Decision Services:"
    ADS=$(oc get icp4aautomationdecisionservices icp4adeploy -n $cp4baProjectName -o 'jsonpath={.status.conditions}')
    echo $ADS  | jq -r '.[] | [.lastTransitionTime, .type, .status, .reason, .message]|@tsv' | sed 's/^/   /g' | sed 's/\\n/\n\t\t\t\t/g'
fi
echo


# TODO: Check the other components, print one line for each if all is "Ready".

if oc -n $cp4baProjectName get secret ibm-iam-bindinfo-platform-auth-idp-credentials  -n $cp4baProjectName >/dev/null 2>&1; then
    IAMUSER=$(oc -n $cp4baProjectName get secret ibm-iam-bindinfo-platform-auth-idp-credentials -o jsonpath='{.data.admin_username}'  -n $cp4baProjectName | base64 -d)
    IAMPW=$(oc -n $cp4baProjectName get secret ibm-iam-bindinfo-platform-auth-idp-credentials -o jsonpath='{.data.admin_password}'  -n $cp4baProjectName | base64 -d)
    echo "IAM Login details: $IAMUSER / $IAMPW"
fi

if oc -n $cp4baProjectName get secret iaf-system-elasticsearch-es-default-user >/dev/null  -n $cp4baProjectName 2>&1; then
    ESUSER=$(oc -n $cp4baProjectName get secret iaf-system-elasticsearch-es-default-user -o jsonpath='{.data.username}'  -n $cp4baProjectName | base64 -d)
    ESPW=$(oc -n $cp4baProjectName get secret iaf-system-elasticsearch-es-default-user -o jsonpath='{.data.password}'  -n $cp4baProjectName | base64 -d)
    echo "IAF Elasticsearch login details: $ESUSER / $ESPW"
fi

if oc -n $cp4baProjectName get secret ibm-dba-ads-runtime-secret  -n $cp4baProjectName >/dev/null 2>&1; then
    ADSUSER=$(oc -n $cp4baProjectName get secret ibm-dba-ads-runtime-secret -o jsonpath='{.data.decisionServiceUsername}'  -n $cp4baProjectName | base64 -d)
    ADSPW=$(oc -n $cp4baProjectName get secret ibm-dba-ads-runtime-secret -o jsonpath='{.data.decisionServicePassword}'  -n $cp4baProjectName | base64 -d)
    echo "ADS Decision Service login details: $ADSUSER / $ADSPW"
fi

if oc get secrets icp4adeploy-insights-engine-flink-admin-user -n $cp4baProjectName >/dev/null 2>&1;  then
    INSIGHTS_USER=$(oc get secrets icp4adeploy-insights-engine-flink-admin-user -n $cp4baProjectName -o jsonpath='{.data.username}' | base64 -d)
    INSIGHTS_PW=$(oc get secrets icp4adeploy-insights-engine-flink-admin-user  -n $cp4baProjectName -o jsonpath='{.data.password}' | base64 -d)
    echo "Insights Engine Flink User UI login details: $INSIGHTS_USER / $INSIGHTS_PW"
fi
