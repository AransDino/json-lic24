@echo off
REM Guardar el directorio actual
set CURRENT_DIR=%cd%

REM Ruta del script PowerShell
set SCRIPT_PATH=C:\Users\ayoze\gitrepositories\TORNEO-LIC-ESTRUCTURA\GENERADOR DE DOCUMENTOS\ConvertAllPDFsToImages.ps1

REM Cambiar la política de ejecución para permitir la ejecución de scripts
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope Process -Force"

REM Ejecutar el script PowerShell
powershell -ExecutionPolicy Bypass -File "%SCRIPT_PATH%"

REM Revertir la política de ejecución (opcional)
powershell -Command "Set-ExecutionPolicy Restricted -Scope Process -Force"

REM Regresar al directorio original
cd /d %CURRENT_DIR%

echo Script ejecutado con éxito.
pause
