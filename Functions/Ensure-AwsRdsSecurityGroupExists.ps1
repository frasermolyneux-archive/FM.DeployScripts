function Ensure-AwsRdsSecurityGroupExists {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)] [String] $ApplicationName,
        [Parameter(Mandatory = $true)] [String] $EnvironmentName
    )
    
    begin {
        Write-Debug "Begin ensure AWS RDS security exists for $ApplicationName\$EnvironmentName"
    }
    
    process {

        $groupName = "$($ApplicationName)-$EnvironmentName-AWS-RDS-DatabaseSecurityGroup"
        $groupDescription = "$($ApplicationName)-$EnvironmentName-AWS-RDS-DatabaseSecurityGroup"
        
        try {
            $databaseAccessGroup = Get-EC2SecurityGroup -GroupName $groupName
        } 
        catch {
            Write-Information "Creating Security Group named $groupName for $ApplicationName\$EnvironmentName"
            New-EC2SecurityGroup -GroupName $groupName -GroupDescription $groupDescription
        }

    }
    
    end {
        Write-Debug "End ensure AWS RDS security exists for $ApplicationName\$EnvironmentName"
    }
}