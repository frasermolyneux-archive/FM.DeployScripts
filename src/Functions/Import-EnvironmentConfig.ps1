function Import-EnvironmentConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)] [String] $Environment,
        [Parameter(Mandatory = $true)] [String] $ConfigDir
    )
    
    begin {
        Write-Debug "Begin importing environment config for environment $Environment in $ConfigDir"

        [HashTable] $configurationData = @{}
        [System.Collections.ArrayList]$configs = @()
    }
    
    process {

        if ((Test-Path -Path "$ConfigDir\..\Environments\Environment.$Environment.psd1") -eq $false) {
            Write-Error "The environment file for $Environment does not exist in $ConfigDir"
        }

        $configs.Add("$ConfigDir\..\Environments\Environment.Base.psd1") | Out-Null
        $configs.Add("$ConfigDir\..\Environments\Environment.$Environment.psd1") | Out-Null

        [System.Collections.ArrayList]$configFileData = @()

        $configs | ForEach-Object {
            $configData = (Import-PowerShellDataFile -Path $_)
            $configFileData.Add($configData) | Out-Null
        }
    
        $configurationData = $configFileData | Merge-HashTables
    }
    
    end {
        Write-Debug "End importing environment config for environment $Environment in $ConfigDir"
        return $configurationData
    }
}