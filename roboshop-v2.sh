#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
ZONE_ID="Z03822472J12MWULO7O9D" # replace with your zone ID
DOMAIN_NAME="daws90s.sbs" # replace with your domain
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

### Validation ###
if [ $# -lt 2 ]; then
    echo -e "$R ERROR:: Atleast 2 arguments required $N"
    echo "USAGE: $0 [create/delete] [instance1] [instance2...]"
    exit 1
fi

ACTION=$1
shift # first argument will be removed

if [ "$ACTION" != "create" ] && [ "$ACTION" != "delete" ]; then
    echo -e "$R ERROR:: First argument must be either create or delete $N"
    echo "USAGE: $0 [create/delete] [instance1] [instance2...]"
    exit 1
fi

get_instance_id(){
    name=$1
    aws ec2 describe-instances --filters "Name=tag:Name,Values=roboshop-$name" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].InstanceId" --output text
}

for instance in $@
do
    get_instance_id $instance
done