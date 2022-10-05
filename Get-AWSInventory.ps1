[cmdletbinding()]
param(
    $awsProfileNames = @('default'),
    $awsRegionList = @('us-east-1','us-east-2','eu-west-1'),
    $metricBase = "inventory.aws",
    $epochTime = (Get-Date -AsUTC -UFormat %s)
)
#inventory.aws.profile.region.resourceType.count
#inventory.aws.profile.region.resourceType.missingtags

ForEach( $awsProfile in $awsProfileNames){
    Write-verbose "Processing profile: $awsprofile"
    Write-verbose "Processing region-specific resources"

    ForEach( $regionName in $awsRegionList){
        #EC2 VPCs
        $metricName = "$metricBase.$awsProfile.$regionName.ec2vpc"
        $metric = (Get-EC2Vpc -Region $regionName -ProfileName $awsProfile).Count
        "$metricName $metric $epochTime"   

        #EC2 Subnets
        $metricName = "$metricBase.$awsProfile.$regionName.ec2subnet"
        $metric = (Get-EC2Subnet -Region $regionName -ProfileName $awsProfile).Count
        "$metricName $metric $epochTime"   

        #EC2 Instances
        $metricName = "$metricBase.$awsProfile.$regionName.ec2instance"
        $metric = (Get-EC2Instance -Region $regionName -ProfileName $awsProfile).Count
        "$metricName $metric $epochTime"     

        #Elastic IPs
        $metricName = "$metricBase.$awsProfile.$regionName.elasticip"
        $metric = (Get-EC2Address -Region $regionName -ProfileName $awsProfile).Count
        "$metricName $metric $epochTime" 

        #Lambda Functions
        $metricName = "$metricBase.$awsProfile.$regionName.lambda"
        $metric = (Get-LMFunctions -Region $regionName -ProfileName $awsProfile).Count
        "$metricName $metric $epochTime" 

        #SNS Subscriptions
        $metricName = "$metricBase.$awsProfile.$regionName.lambda"
        $metric = (Get-SNSSubscription -Region $regionName -ProfileName $awsProfile).Count
        "$metricName $metric $epochTime" 

        #SNS Topics
        $metricName = "$metricBase.$awsProfile.$regionName.lambda"
        $metric = (Get-SNSTopic -Region $regionName -ProfileName $awsProfile).Count
        "$metricName $metric $epochTime" 

        #Cloud trails
        $metricName = "$metricBase.$awsProfile.$regionName.cloudtrail"
        $metric = (Get-CTTrail -Region $regionName -ProfileName $awsProfile).Count
        "$metricName $metric $epochTime" 

    }
    Write-verbose ""

    Write-verbose "Processing region-specific resources"
    #S3 Buckets
    $metricName = "$metricBase.$awsProfile.all.s3bucket"
    $metric = (Get-S3Bucket -ProfileName $awsProfile).Count
    "$metricName $metric $epochTime"   

    #IAM Users
    $metricName = "$metricBase.$awsProfile.all.iamuser"
    $metric = (Get-IAMUsers -ProfileName $awsProfile).Count
    "$metricName $metric $epochTime"   

    #IAM Groups
    $metricName = "$metricBase.$awsProfile.all.iamgroup"
    $metric = (Get-IAMGroups -ProfileName $awsProfile).Count
    "$metricName $metric $epochTime"   

    #IAM Roles
    $metricName = "$metricBase.$awsProfile.all.iamrole"
    $metric = (Get-IAMRoles -ProfileName $awsProfile).Count
    "$metricName $metric $epochTime"   

}