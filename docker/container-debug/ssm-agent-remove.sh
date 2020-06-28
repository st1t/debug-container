#!/bin/bash

ACTIVATE_ID=$(cat /tmp/ssm-activate-id.txt)
INSTANCE_ID=$(aws ssm describe-instance-information --filters Key=ActivationIds,Values=$ACTIVATE_ID --query InstanceInformationList[].InstanceId --output text)

aws ssm delete-activation --activation-id $ACTIVATE_ID
aws ssm deregister-managed-instance --instance-id $INSTANCE_ID
