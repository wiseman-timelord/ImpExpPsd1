# ImpExpPsd1-ClPs

### STATUS
Development. The principles are...
- focus on, competence and reliability and efficiency, but do not introduce "security".
- ensure the cmdlets work for, "PowerShell Core 7" and "Powershell 5.1", ensure everything is compatible.
- we ideally want them to work more, competently and faster, than the PowerShell/PowerShellCore versions of the relating cmdlets.
- we want them to utilize exactly the same, syntax and usage, for import, and a fitting theme of, syntax and usage, for the export, compared to the powershell import. 

## DESCRIPTION
Powershell and PowerShellCore do not have an Export-PowerShellDataFile cmdlet, therein, every time the given user attemts to use a Psd1 with a script created in GPT4, then it will cause a series of different errors in development to happen, that are frustrating interactions if you intend to use Psd1, hence, I wanted to solve that issue, and not only that, but produce upgrades in the process. ImpExpPsd1-Cl will fix the issue of incorrectly reading/writing to PSD1's with perfected, import and export, cmdlets, that are, robust and efficient, hence, "Import Export Psd1", cmdlets and powershell script, were created for exactly this purpose. There is a "Export-PowerShellDataFile" on GitHub, however, mine will be, better than, that and the standard "Import-PowerShellDataFile" cmdlet.

### DEMONSTRATION
- Some GPT4 logic upon exporting Psd1 files (in a new session - 2024/01/24)...
```
WT:
Powershell and PowerShellCore do not have an Export-PowerShellDataFile cmdlet, is this, true or false?

GPT4:
The statement is false. Both PowerShell and PowerShell Core do include the `Export-PowerShellDataFile` cmdlet...
...
```
- Standard Psd1 import has issues...
```
WT:
Please tell me about the, limitations and issues, of Import-PowerShellDataFile.

GPT4: 
...
Handling Complex Data: While it can import nested hashtables or custom objects, the complexity of the data structure can lead to confusion or errors in interpretation.
...
```

## USAGE
- There will be an installer for the cmdlets, they will be in a module.
- The, syntax and usage, of the import will work the same...
```
$ConfigData = WtImp-PowerShellData1 -Path "C:\path\to\config.psd1"

$Setting1Value = $ConfigData.Setting1
```
- The, syntax and usage, of the export will work as GPT hallucinated it would...
```
$data = @{
    Setting1 = 'Value1'
    Setting2 = 'Value2'
}

$data | WtExp-PowerShellData1 -Path 'C:\path\to\your\file.psd1'
```

### NOTATION
- The other dudes export psd cmdlet is [here](https://github.com/rhubarb-geek-nz/PowerShellDataFile/), its v1.0 currently.

## DISCLAIMER
This software is subject to the terms in License.Txt, covering usage, distribution, and modifications. For full details on your rights and obligations, refer to License.Txt.


