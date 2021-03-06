param (
    [string[]]$regions = @(
        "us-east-1",
        "us-east-2",
        "us-west-1",
        "us-west-2",
        "ca-central-1",
        "ap-south-1",
        "ap-northeast-2",
        "ap-southeast-1",
        "ap-southeast-2",
        "ap-northeast-1",
        "eu-central-1",
        "eu-west-1",
        "eu-west-2",
        "sa-east-1"
    ),
    [string]$stackName = "ThousandServersAuto"
    # [string]$stackName = "ThousandServersPipeline"
)

foreach($region in $regions)
{
    $stacks = aws cloudformation describe-stacks --stack-name $stackName --region $region 2>$null
    
    if ($LASTEXITCODE -eq 0) {
        $stacks |
        ConvertFrom-Json |
        select -expand Stacks |
        ForEach-Object { Write-Host $region ":" $_.StackStatus }
    } else {
        Write-Host $region ": N/A"
    }
}