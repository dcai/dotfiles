complete -C aws_completer aws

function kinesis_delete() {
  if [ $# -lt 1 ]; then
    echo "Provide stream name please"
    return 1
  fi
  aws --output table kinesis delete-stream --stream-name $1
}

function cfn_delete() {
  if [ $# -lt 1 ]; then
    echo "Provide stack name please"
    return 1
  fi
  aws --output table cloudformation delete-stack --stack-name $1
  aws --output table cloudformation wait stack-delete-complete --stack-name $1
}
