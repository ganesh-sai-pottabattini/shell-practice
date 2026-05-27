#! /bin/bash

#user passes the args while running the script - sh 2roboshop.sh create mongodb
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

AMI_ID="ami-0220d79f3f480ecf5"
HOSTED_ZONE="Z00461041245SLKVHKSS7"
DOMAIN_NAME="trivikram.online"

if [ $# -lt 2 ]; then
echo -e " $R Please pass atleast two args $N "
echo " syntax : $0 [create/delete] [instance_name1] [instance_name2] [instance_name3] ...... "
exit 1
fi

ACTION=$1
shift 

if [ $ACTION != "create"] && [ $ACTION != "delete" ]; then
echo -e "$R ERROR:: First argument must be either create or delete $N"
echo "USAGE: $0 [create/delete] [instance1] [instance2...]"
exit 1
fi

# get_instance_id(){
#     name=$1
#     aws ec2 describe-instances --filters "Name=tag:Name,Values=roboshop-$name" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].InstanceId" --output text
# }

instance=$1
if [ "$ACTION" == "create" ]; then

INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$instance" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].InstanceId" --output text)

if [ "INSTANCE_ID" == "None"]
    echo "Launching Instance "
    INSTANCE_ID=$( aws ec2 run-instances \
            --image-id $AMI_ID \
            --instance-type t3.micro \
            --security-groups "common" "$instance" \
            --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
            --query 'Instances[0].InstanceId' \
            --output text 
            )
    echo "Launched Instance, Instance-Id : $INSTANCE_ID"

else 
echo "$instance already running: $INSTANCE_ID"

#update the ip in r53 records

    if [ $instance == "frontend" ]; then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID \
            --query 'Reservations[*].Instances[*].PublicIpAddress' \
            --output text
            )
        R53_RECORD="$DOMAIN_NAME"
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID \
            --query 'Reservations[*].Instances[*].PrivateIpAddress' \
            --output text
            )
            R53_RECORD="$instance.$DOMAIN_NAME"
    fi

        aws route53 change-resource-record-sets \
    --hosted-zone-id $HOSTED_ZONE \
    --change-batch '
    {
        "Comment": "Updating A record for IP",
        "Changes": 
        [
            {
                "Action": "UPSERT",
                "ResourceRecordSet": 
                {
                    "Name": "'$R53_RECORD'",
                    "Type": "A",
                    "TTL": 1,
                    "ResourceRecords": 
                    [
                        {
                            "Value": "'$IP'"
                        }
                    ]
                }     
            }
        ]
    }
 '


 
