#!/bin/bash

set -e

if [ "$SSM_ACTIVATE" = "true" ]; then
  ACTIVATE_PARAMETERS=$(aws ssm create-activation \
    --default-instance-name "container-debug" \
    --description "container-debug" \
    --iam-role "service-role/AmazonEC2RunCommandRoleForManagedInstances" \
    --registration-limit 5)

  export ACTIVATE_CODE=$(echo $ACTIVATE_PARAMETERS | jq -r .ActivationCode)
  export ACTIVATE_ID=$(echo $ACTIVATE_PARAMETERS | jq -r .ActivationId)
  echo $ACTIVATE_ID > /tmp/ssm-activate-id.txt
  amazon-ssm-agent -register -code "${ACTIVATE_CODE}" -id "${ACTIVATE_ID}" -region "ap-northeast-1" -y
  nohup amazon-ssm-agent > /dev/null &
fi

sleep 32400