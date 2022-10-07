#!/bin/bash
  
token=118f7891a169867fa99c3745545774c444
host=$( oc get route jenkins -o jsonpath='{.spec.host}' )
job="https://${host}/job/hello/job/main"

if json=$( curl --fail -sk "${job}/lastBuild/api/json" --user "developer-admin-edit-view:${token}" )
then
  number=$( echo "${json}" | jq -r '.number' )
  result=$( echo "${json}" | jq -r '.result' )
  echo "Result of the last build (#${number}) from hello/main is: ${result}."
else
  echo "Error from curl invoking the Jenkins API: $?"
fi
