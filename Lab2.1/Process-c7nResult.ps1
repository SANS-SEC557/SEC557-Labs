#Process the resources.json file for a large number of services scanned by Custodian
[cmdletbinding()]
param(
    $metricBase = "compliance.aws.missingtag",
    $epochTime = (Get-Date -AsUTC -UFormat %s)
)

foreach( $filespec in Get-ChildItem ./$StartDir/*/resources.json -Recurse ) { 
    $resourceName = ($filespec.DirectoryName) -replace ".*\/" , '' -replace '-tag-compliance'
    $resourceCount = (Get-Content $filespec.FullName | ConvertFrom-Json).Count

    "$metricBase.$resourceName $resourceCount $epochTime" 
}