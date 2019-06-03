function Ensure-AwsRdsSecurityGroupExists {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)] [String] $Environment
    )
    
    begin {
        Write-Debug "Begin ensure AWS RDS security exists for $Environment"
    }
    
    process {

        $groupName = "$($ApplicationName)-$Environment-AWS-RDS-DatabaseSecurityGroup"
        $groupDescription = "$($ApplicationName)-$Environment-AWS-RDS-DatabaseSecurityGroup"
        
        try {
            $databaseAccessGroup = Get-EC2SecurityGroup -GroupName $groupName
        } 
        catch {
            Write-Information "Creating Security Group named $groupName for $Environment"
            New-EC2SecurityGroup -GroupName $groupName -GroupDescription $groupDescription
        }

    }
    
    end {
        Write-Debug "End ensure AWS RDS security exists for $Environment"
    }
}