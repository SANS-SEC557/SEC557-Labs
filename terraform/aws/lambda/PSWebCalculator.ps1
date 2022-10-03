# PowerShell script file to be executed as a AWS Lambda function. 
# 
# When executing in Lambda the following variables will be predefined.
#   $LambdaInput - A PSObject that contains the Lambda function input data.
#   $LambdaContext - An Amazon.Lambda.Core.ILambdaContext object that contains information about the currently running Lambda environment.
#
# The last item in the PowerShell pipeline will be returned as the result of the Lambda function.
#
# To include PowerShell modules with your Lambda function, like the AWS.Tools.S3 module, add a "#Requires" statement
# indicating the module and version. If using an AWS.Tools.* module the AWS.Tools.Common module is also required.


#Requires -Modules @{ModuleName='AWS.Tools.Common';ModuleVersion='4.1.16.0'}

# Uncomment to send the input event to CloudWatch Logs
Write-Host (ConvertTo-Json -InputObject $LambdaInput -Compress -Depth 5)


# if ($LambdaInput) {
#     $path = $LambdaInput.path
# }
# else {
#     # Test value when running locally.
     $path = "/add/10/20"
# }


if($path.StartsWith("/")) {
    $path = $path.Substring(1)
}

$tokens = $path -split "/"


switch($tokens[0])
{
    'add' {$result = [double]$tokens[1]  + [double]$tokens[2]}
    'sub' {$result = [double]$tokens[1]  - [double]$tokens[2]}
    'mul' {$result = [double]$tokens[1]  * [double]$tokens[2]}
    'div' {$result = [double]$tokens[1]  / [double]$tokens[2]}
}

@{
    'statusCode' = 200;
    'body' = $result;
    'headers' = @{'Content-Type' = 'text/plain'}
}