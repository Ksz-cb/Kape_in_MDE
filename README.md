# Kape_in_MDE
Scripts allowing comfortable usage of KAPE in MDE Live Response

## Prerequisite steps:

- Download KAPE 

- Create a ZIP file named kape.zip by compressing kape.exe and the Target directory

- Download powershell scripts 

- Upload PowerShell scripts and kape.zip to MDE Live Response library

## Steps to collect artifacts during incident:

- Connect to the remote machine using the Live Response feature of Microsoft Defender.

- Upload the kape.zip to the remote machine using the “putfile” command

```
C:\> putfile kape.zip
```

- Execute prepare_kape.ps1 to copy kape.zip to C:\Users\Public and unpack it. After that go to C:\Users\Public\kape. 

```
C:\> run Prepare_kape.ps1 
C:\> cd C:\Users\Public\kape
```

- Determine whether to use Run_def_kape.ps1 or Run_mod_kape.ps1. The main difference is that script with DEF in the name, at the beginning of targets to collect has $MFT, $J and $LogFile. I did it in that way, because i had huge issue with escaping $ in PowerShell parameters.

Example:

```
1. C:\> run Run_def_kape.ps1 1Password,AnyDesk,PowerShellConsole
 
OR
 
2. C:\> run Run_mod_kape.ps1 1Password,AnyDesk,PowerShellConsole

Above commands will give effect seen below 


1. .\kape.exe --tsource C: --tdest C:\Users\Public\kape\collection --target $MFT,$J,$LogFile,1Password,AnyDesk,PowerShellConsole
 
OR
 
2. .\kape.exe --tsource C: --tdest C:\Users\Public\kape\collection --target 1Password,AnyDesk,PowerShellConsole
```
After that in folder KAPE will be 2 new elements, folder collection with collected artifacts and ZIP archive of that folder.

- Collect created zip with command getfile:

```
C:\> getfile C:\Users\Public\kape\collection.zip
```

*Please remember Live Response has limitation to 3GB filesize so if you collect recycle bin with kape the size might be too large.*

- Clean after yourself. To prevent leaving around 1GB artifacts execute Clean_kape.ps1. This script simply removes C:\Users\Public\kape.zip archive and C:\Users\Public\kape directory. 

```
C:\> run Clean_kape.ps1
```
