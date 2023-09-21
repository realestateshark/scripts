#!/bin/sh

source package/install-package.sh

usage() {
	echo "Usage: $0"
	echo
	echo "Options:"
	echo " [-p | --profile <profile>]: The AWS-CLI profile that shall be used. Defaults to 'immosolve-play'."
	echo " [-h | --help]: Shows this help."
	exit 1
}

install_package "jq"

while [ "$1" != "" ]; do
    case $1 in
        (-p | --profile) shift
        PROFILE="$1"
        ;;

        (-h | --help)
        usage
        exit 1
        ;;

        (*)
        echo "Unknown parameter '$1'!"
        echo
        usage
        exit 1
    esac
    shift
done

if [ -z "$PROFILE" ]; then
    PROFILE="immosolve-play"
fi

export AWS_ROLE_ARN=$(aws configure get role_arn --profile $PROFILE)
RESULT=$(aws sts assume-role --role-arn "$AWS_ROLE_ARN" --role-session-name AWSCLI-Session --profile "$PROFILE")
echo "export AWS_ACCESS_KEY_ID=$(echo "$RESULT" | jq -r '.Credentials.AccessKeyId')"
echo "export AWS_SECRET_ACCESS_KEY=$(echo "$RESULT" | jq -r '.Credentials.SecretAccessKey')"
echo "export AWS_SESSION_TOKEN=$(echo "$RESULT" | jq -r '.Credentials.SessionToken')"
