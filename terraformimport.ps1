#Variables initialization
$TFVARS = Read-Host "Please enter TFVARS file name without .var"
$APP_NAME = Read-Host "Please enter APP Name"
$ACCT_ID = Read-Host "Please enter account ID"
$WORKSPACE = Read-Host "Please enter workspace name"

#Mandatory Commands
terraform init
terraform workspace select $WORKSPACE

$ADMIN_ROLE = $(Write-Host "Do you want to import" -NoNewline) + $(Write-Host " admin role?" -ForegroundColor Red -NoNewline) +$(Write-Host " yes or no: " -ForegroundColor yellow -NoNewLine; Read-Host)

function automate-admin-role {
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role.admin_saml_role cfg-saml-$APP_NAME-admin
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.admin-saml-default-policies[0] cfg-saml-$APP_NAME-admin/arn:aws:iam::aws:policy/AWSCloudTrailReadOnlyAccess
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.admin-saml-default-policies[1] cfg-saml-$APP_NAME-admin/arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.admin-saml-default-policies[2] cfg-saml-$APP_NAME-admin/arn:aws:iam::aws:policy/AWSSupportAccess
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.admin-saml-default-policies[3] cfg-saml-$APP_NAME-admin/arn:aws:iam::$ACCT_ID:policy/cfg-deny-protectedNetworkAccess
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.admin-saml-default-policies[4] cfg-saml-$APP_NAME-admin/arn:aws:iam::$ACCT_ID:policy/cfg-ssm-readwrite
}

if ( $ADMIN_ROLE -eq "yes" ) {
    automate-admin-role    
}

$SUPPORT_ROLE = $(Write-Host "Do you want to import" -NoNewline) + $(Write-Host " support role?" -ForegroundColor Red -NoNewline) +$(Write-Host " yes or no: " -ForegroundColor yellow -NoNewLine; Read-Host)

function automate-support-role {
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role.support_saml_role cfg-saml-$APP_NAME-support
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.saml-support-default-policies[0] cfg-saml-$APP_NAME-support/arn:aws:iam::aws:policy/AWSCloudTrailReadOnlyAccess
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.saml-support-default-policies[1] cfg-saml-$APP_NAME-support/arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.saml-support-default-policies[2] cfg-saml-$APP_NAME-support/arn:aws:iam::aws:policy/AWSSupportAccess
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.saml-support-default-policies[3] cfg-saml-$APP_NAME-support/arn:aws:iam::$ACCT_ID:policy/cfg-deny-protectedNetworkAccess
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.saml-support-default-policies[4] cfg-saml-$APP_NAME-support/arn:aws:iam::$ACCT_ID:policy/cfg-ssm-readwrite
}

if ( $SUPPORT_ROLE -eq "yes" ) {
    automate-support-role    
}

$AUTOMATION_ROLE = $(Write-Host "Do you want to import" -NoNewline) + $(Write-Host " automation role?" -ForegroundColor Red -NoNewline) +$(Write-Host " yes or no: " -ForegroundColor yellow -NoNewLine; Read-Host)

function automate-automation-role {
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role.automation_role cfg-$APP_NAME-automation
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.automation-default-policies[0] cfg-$APP_NAME-automation/arn:aws:iam::aws:policy/AWSCloudTrailReadOnlyAccess
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.automation-default-policies[1] cfg-$APP_NAME-automation/arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.automation-default-policies[2] cfg-$APP_NAME-automation/arn:aws:iam::aws:policy/AWSSupportAccess
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.automation-default-policies[3] cfg-$APP_NAME-automation/arn:aws:iam::$ACCT_ID:policy/cfg-deny-protectedNetworkAccess
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.automation-default-policies[4] cfg-$APP_NAME-automation/arn:aws:iam::$ACCT_ID:policy/cfg-ssm-readwrite
}

if ( $AUTOMATION_ROLE -eq "yes" ) {
    automate-automation-role    
}

$LAMBDA_ROLE = $(Write-Host "Do you want to import" -NoNewline) + $(Write-Host " lambda role?" -ForegroundColor Red -NoNewline) +$(Write-Host " yes or no: " -ForegroundColor yellow -NoNewLine; Read-Host)

function automate-lambda-role {
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role.lambda_role cfg-$APP_NAME-lambda-execution-role
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.lambda-default-policies[0] cfg-$APP_NAME-lambda-execution-role/arn:aws:iam::$ACCT_ID:policy/lambda-execution-role
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.lambda-default-policies[1] cfg-$APP_NAME-lambda-execution-role/arn:aws:iam::$ACCT_ID:policy/cfg-ssm-limited
}

if ( $LAMBDA_ROLE -eq "yes" ) {
    automate-lambda-role
}



$EC2_ROLE = $(Write-Host "Do you want to import" -NoNewline) + $(Write-Host " ec2 role?" -ForegroundColor Red -NoNewline) +$(Write-Host " yes or no: " -ForegroundColor yellow -NoNewLine; Read-Host)

function automate-ec2-role {
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role.application_role cfg-$APP_NAME-infrastructure-ec2-us-east-1
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.default-policies[0] cfg-$APP_NAME-infrastructure-ec2-us-east-1/arn:aws:iam::$ACCT_ID:policy/cfg-policy-infrastructure-ec2-us-east-1
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.default-policies[1] cfg-$APP_NAME-infrastructure-ec2-us-east-1/arn:aws:iam::$ACCT_ID:policy/cfg-create-tags
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.default-policies[2] cfg-$APP_NAME-infrastructure-ec2-us-east-1/arn:aws:iam::$ACCT_ID:policy/cfg-infrastructure-ec2-ssm
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_instance_profile.application_profile cfg-$APP_NAME-infrastructure-ec2-us-east-1
}

if ( $EC2_ROLE -eq "yes" ) {
    automate-ec2-role
}

$CODE_DEPLOY_POLICY = $(Write-Host "Do you want to import" -NoNewline) + $(Write-Host " code deploy policy?" -ForegroundColor Red -NoNewline) +$(Write-Host " yes or no: " -ForegroundColor yellow -NoNewLine; Read-Host)

function automate-code-deploy {
    terraform import -var-file="../tfe-aws-iam-role-envs/environments/$TFVARS.tfvars" aws_iam_role_policy_attachment.ec2-codepipeline cfg-$APP_NAME-infrastructure-ec2-us-east-1/arn:aws:iam::$ACCT_ID:policy/cfg-ec2-codepipeline-access
}

if ( $CODE_DEPLOY_POLICY -eq "yes" ) {
    automate-code-deploy
}
