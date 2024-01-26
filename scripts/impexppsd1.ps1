# Script: impexppsd1.ps1

# Title: Wiseman-Timelords Import/Export Script 
# Url: https://github.com/wiseman-timelord/ImpExpPsd1-Ps
#
# Import Syntax:
# $ConfigData = Import-PowerShellData1 -Path "C:\path\to\config.psd1"
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
# $data | Export-PowerShellData1 -Path 'C:\path\to\your\file.psd1'
# or
# $data | Export-PowerShellData1 -Path 'C:\path\to\your\file.psd1' -Name

# Function Import Psd1
function Import-PowerShellData1 {
    param (
        [string]$Path
    )
    $content = Get-Content -Path $Path -Raw
    $content = $content -replace '^(#.*[\r\n]*)+', '' # Remove lines starting with '#'
    $content = $content -replace '\bTrue\b', '$true' -replace '\bFalse\b', '$false'
    $scriptBlock = [scriptblock]::Create($content)
    $data = . $scriptBlock
    return $data
}

# Function Export Psd1
function Export-PowerShellData1 {
    param (
        [Parameter(Mandatory = $true)]
        [hashtable]$Data,
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [switch]$Name
    )
    function ConvertTo-Psd1Content {
        param ($Value)
        switch ($Value) {
            { $_ -is [System.Collections.Hashtable] } {
                "@{" + ($Value.GetEnumerator() | ForEach-Object {
                    "`n    $($_.Key) = $(ConvertTo-Psd1Content $_.Value)"
                }) -join ";" + "`n}" + "`n"
            }
            { $_ -is [System.Collections.IEnumerable] -and $_ -isnot [string] } {
                "@(" + ($Value | ForEach-Object {
                    ConvertTo-Psd1Content $_
                }) -join ", " + ")"
            }
            { $_ -is [PSCustomObject] } {
                $hashTable = @{}
                $_.psobject.properties | ForEach-Object { $hashTable[$_.Name] = $_.Value }
                ConvertTo-Psd1Content $hashTable
            }
            { $_ -is [string] } { "`"$Value`"" }
            { $_ -is [int] -or $_ -is [long] -or $_ -is [bool] -or $_ -is [double] -or $_ -is [decimal] } { $_ }
            default { 
                "`"$Value`"" 
            }
        }
    }
    $fileName = if ($Name) { Split-Path $Path -Leaf } else { $null }
    $psd1Content = if ($fileName) { "# Script: $fileName`n`n" } else { "" }
    $psd1Content += "@{" + ($Data.GetEnumerator() | ForEach-Object {
        "`n    $($_.Key) = $(ConvertTo-Psd1Content $_.Value)"
    }) -join ";" + "`n" + "}"
    Set-Content -Path $Path -Value $psd1Content -Force
}


