# Script: impexppsd1.ps1

# Title: Wiseman-Timelords Import/Export Script 
# Url: https://github.com/wiseman-timelord/ImpExpPsd1-Ps
#
# Import Syntax:
# $ConfigData = WtImp-PowerShellData1 -Path "C:\path\to\config.psd1"
#
# Import Usage:
# $Setting1Value = $ConfigData.Setting1
#
# Export Syntax: 
# $data = @{
#     Setting1 = 'Value1'
#     Setting2 = 'Value2'
# }
#
# Export Usage:
# $data | WtExp-PowerShellData1 -Path 'C:\path\to\your\file.psd1'

# Function Import Psd1
function WtImp-PowerShellData1 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $content = Get-Content -Path $Path -Raw
    Invoke-Expression $content
}

# Function Export Psd1
function WtExp-PowerShellData1 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [hashtable]$Data,

        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    process {
        function ConvertTo-Psd1Content {
            param ($Value)
            switch ($Value) {
                { $_ -is [System.Collections.Hashtable] } {
                    "@{" + ($Value.GetEnumerator() | ForEach-Object {
                        "$($_.Key) = $(ConvertTo-Psd1Content $_.Value)"
                    }) -join "; " + "}"
                }
                { $_ -is [System.Collections.IEnumerable] -and $_ -isnot [string] } {
                    "@(" + ($Value | ForEach-Object {
                        ConvertTo-Psd1Content $_
                    }) -join ", " + ")"
                }
                { $_ -is [string] } { "`"$Value`"" }
                default { $_ }
            }
        }

        $psd1Content = "@{" + ($Data.GetEnumerator() | ForEach-Object {
            "`n    $($_.Key) = $(ConvertTo-Psd1Content $_.Value)"
        }) -join "" + "`n}"

        Set-Content -Path $Path -Value $psd1Content -Force
    }
}
