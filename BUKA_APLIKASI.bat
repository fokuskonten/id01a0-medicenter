@echo off
setlocal enabledelayedexpansion
title Membuka MediCenter - FokusKonten
cls

echo ================================================================================
echo   MELUNCURKAN MediCenter (DESKTOP MODE)
echo   FokusKonten Official Digital Software (https://fokuskonten.my.id)
echo ================================================================================
echo.

set "XAMPP_DIR="
if exist "C:\xampp\apache\bin\httpd.exe" set "XAMPP_DIR=C:\xampp"
if not defined XAMPP_DIR if exist "D:\xampp\apache\bin\httpd.exe" set "XAMPP_DIR=D:\xampp"
if not defined XAMPP_DIR if exist "E:\xampp\apache\bin\httpd.exe" set "XAMPP_DIR=E:\xampp"

if defined XAMPP_DIR (
    netstat -ano | findstr LISTENING | findstr /R /C:":80 " >nul
    if errorlevel 1 (
        echo [*] Menyalakan modul server web Apache di latar belakang...
        start "" /D "!XAMPP_DIR!" /min "!XAMPP_DIR!\apache\bin\httpd.exe"
    )
    
    netstat -ano | findstr LISTENING | findstr /R /C:":3306 " >nul
    if errorlevel 1 (
        echo [*] Menyalakan modul basis data MySQL di latar belakang...
        start "" /D "!XAMPP_DIR!" /min "!XAMPP_DIR!\mysql\bin\mysqld.exe" --defaults-file="!XAMPP_DIR!\mysql\bin\my.ini" --standalone
    )
    
    ping 127.0.0.1 -n 2 >nul
)

set "TARGET_URL=http://localhost/medicenter/public/"

echo [*] Membuka aplikasi...
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" --app="!TARGET_URL!" --window-size=1280,800
    exit
)
if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" --app="!TARGET_URL!" --window-size=1280,800
    exit
)
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
    start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" --app="!TARGET_URL!" --window-size=1280,800
    exit
)

start !TARGET_URL!
exit
