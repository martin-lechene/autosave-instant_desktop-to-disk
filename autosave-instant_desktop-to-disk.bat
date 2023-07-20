@echo off

REM Chemin source
set src_folder=C:\Users\root\Code

REM Chemin de destination
set today=%date:~6,4%-%date:~3,2%-%date:~0,2%
set time=%time:~0,2%
set dest_folder=E:\instant\instant_%today%-%time%H
if not exist "%dest_folder%" mkdir "%dest_folder%"

REM Copier les fichiers et dossiers du répertoire source vers le répertoire destination
xcopy /s /e /i "%src_folder%" "%dest_folder%"

REM Déplacer les anciens fichiers vers le répertoire "instant_old"
for /d %%F in ("%dest_folder%\*") do (
    for /f "tokens=1-3 delims=/ " %%A in ("%%~tF") do (
        set /a "filetime=(((%%C * 10000) + (%%B * 100) + %%A) * 100) + %%~tF%%~zF%%~xF / 2"
    )
    set /a "onemonthago=((((((%date:~6,4% - 1900) * 512) + (%date:~3,2% - 1) * 32) + %date:~0,2%) * 65536) + %time:~0,2% * 3600 + %time:~3,2% * 60 + %time:~6,2% - 2592000) * 10000000"
    if !filetime! lss !onemonthago! (
        set old_folder=E:\instant\instant_old\%%~nxF
        move "%%F" "!old_folder!"
    )
)
