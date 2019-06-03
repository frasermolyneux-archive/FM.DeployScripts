function New-ZipArtifactArchive {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)] [String] $WebsiteFilePath,
        [Parameter(Mandatory = $true)] [String] $ArchiveName,
        [Parameter(Mandatory = $true)] [String] $WorkingDirectory
    )
    
    begin {
        Write-Debug "Begin creating Zip artifact archive $ArchiveName for $WebsiteFilePath in $WorkingDirectory"
    }
    
    process {

        if ((Test-Path -Path "$WorkingDirectory\$ArchiveName.zip") -eq $true) {
            Remove-Item -Path "$WorkingDirectory\$ArchiveName.zip" -Force
        }

        $customEncoder = '
        using System.Text;
        public class CustomEncoder : UTF8Encoding
        {
            public override byte[] GetBytes(string s)
            {
                s = s.Replace("\\", "/");
                return base.GetBytes(s);
           }
        }'
        
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        Add-Type -TypeDefinition $customEncoder -Language CSharp

        $encoding = [CustomEncoder]::new()
        [System.IO.Compression.ZipFile]::CreateFromDirectory("$WebsiteFilePath", "$WorkingDirectory\$ArchiveName.zip", 'Optimal', $false, $encoding)
        
    }
    
    end {
        Write-Debug "End creating Zip artifact archive $ArchiveName for $WebsiteFilePath in $WorkingDirectory"
    }
}