@echo off
setlocal enabledelayedexpansion

set "FILE_LIST=d3d9.dll SRL.ini"
for %%f in (%FILE_LIST%) do (
    if exist "%%f" del /f /q "%%f"
)

set "DIR_LIST=StringReloads zh-CN"
for %%d in (%DIR_LIST%) do (
    if exist "%%d" rmdir /s /q "%%d"
)

del /f /q "%~f0"