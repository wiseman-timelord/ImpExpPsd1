# ImpExpPsd1

### STATUS
Development. Early version, do not use. The principles are...
- Testing, ensure the cmdlets work for, "PowerShell Core 7" and "Powershell 5.1", ensure everything is compatible.
- we ideally want them to work more competently than the PowerShell/PowerShellCore versions of the relating cmdlets.
- Keep things fast, no security or error handling, the data will be trusted to be, correct from the export and safe (non-executable) from the relating program.
- we want them to utilize exactly the same, syntax and usage, for import, and a fitting theme of, syntax and usage, for the export, compared to the built-in powershell import.
- after the scripts have been, tested and improved, though use in my programs (starting with [BethScale](https://github.com/wiseman-timelord/DdsBethScale-PsWhile)), then functions will be converted to c# cmdlets, and additionally put on [PowerShellGallery](https://www.powershellgallery.com/packages/). 
- While working on the Powershell based AI LLM thing, consider including pipeline support for multi-window interface, and test. It would also change the usage & syntax. 

## DESCRIPTION
Powershell and PowerShellCore do not have an, Export-PowerShellDataFile cmdlet and require an additional function for boolean conversion for the Import-PowerShellDataFile, therein, every time the given user attemts to use a Psd1 with a script created in GPT4, then it will cause a series of different errors in development to happen, that are frustrating interactions if you intend to use Psd1, hence, I wanted to solve that issue, and not only that, but produce upgrades in the process. ImpExpPsd1-Cl will fix the issue of incorrectly reading/writing to PSD1's with somewhat perfected, import and export, functions and cmdlets, that are, robust and efficient, hence, "Import Export Psd1", functions (cmdlets later too) was created for exactly this purpose.

### FEATURES
- **Standard Features**: The features you find in the built-in import function, including, hashtables, strings, booleans, arrays. 
- **Additional Features**: The features you always wanted...comment adding/handling, automatic true/false to boolean converstion, nested object handling, internal convert to psd1 format, improved string handling.

### PREVIEW
- Example psd1 file (when using export with -Name argument)...
```
# Script: settings.psd1

@{
    ArchiveMultithreading = $true
    UserPreviousScore = "0"
    ProcessCharacterTextures = $false
    GpuCardSelectionNumber = 1
    DataFolderLocation = "C:\Program Files (x86)\Steam\steamapps\common\Fallout 4\data"
    TargetResolution = 2048
    UserCurrentLowScore = "0"
    UserCurrentHighScore = "0"
}
```

## USAGE
1. Install/Import the, script or cmdlet. 
2. Depend on the circumstance...The, syntax and usage, of the import will work the same as the built-in one, hence, you just need to swap the cmdlet names, but, for export the, syntax and usage is similar as GPT hallucinated it to be, but without pipeline, as shown below.
- Import, syntax and usage:
```
$ConfigData = Import-PowerShellData1 -Path "C:\path\to\config.psd1"
$Setting1Value = $ConfigData.Setting1
```
- Export, syntax and usage:
```
Using global with hashtable import...
$Global:Config = Import-PowerShellData1 -Path "C:\path\to\your\file.psd1"
Export-PowerShellData1 -Data $Global:Config -Path "C:\path\to\your\file.psd1"

Using hashtable...
$data = @{
    Setting1 = 'Value1'
    Setting2 = 'Value2'
}
Export-PowerShellData1 -Data $data -Path 'C:\path\to\your\file.psd1'

Options...
-Name (comment "# Script: file.psd1", extracted from -Path detail).
```

### NOTATION
- There is a "Export-PowerShellDataFile" on GitHub [here](https://github.com/rhubarb-geek-nz/PowerShellDataFile/), its v1.0 currently.
- GPT4: "Both PowerShell and PowerShell Core do include the `Export-PowerShellDataFile` cmdlet..." (hallucination).
- GPT4: "While Export-PowerShellDataFile can import nested hashtables or custom objects, the complexity of the data structure can lead to confusion or errors in interpretation."

## DISCLAIMER
This software is subject to the terms in License.Txt, covering usage, distribution, and modifications. For full details on your rights and obligations, refer to License.Txt.


