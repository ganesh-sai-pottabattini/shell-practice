#! /bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
HOSTED_ZONE="Z00461041245SLKVHKSS7"
DOMAIN_NAME="trivikram.online"

for instance in $@
do 
    echo " Launching Instance $instance"
    INSTANCE_ID=$(aws ec2 run-instances \
    --image-id ami-0220d79f3f480ecf5 \
    --instance-type t3.micro \
    --security-groups "common-myIP" "$instance" \
	--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
	--query 'Instances[0].InstanceId' \
    --output text
    )
    echo " INSTANCE_ID=$INSTANCE_ID"

    if [ $instance == "frontend" ]; then
        IP=$(aws ec2 describe-instances \
        --instance-ids $INSTANCE_ID \
        --query "Reservations[*].Instances[*].PublicIpAddress" \
        --output text)

        R53_RECORD="$DOMAIN_NAME"

        else
        IP=$(aws ec2 describe-instances \
            --instance-ids $INSTANCE_ID \
            --query "Reservations[*].Instances[*].PrivateIpAddress" \
            --output text)

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
                    "Name": "'$DOMAIN_NAME'",
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

done