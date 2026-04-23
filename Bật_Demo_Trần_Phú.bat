@echo off
echo ==========================================
echo   DANG KHOI CHAY DEMO TRAN PHU ECOTP
echo ==========================================
cd /d "d:\TP\tranphu_ecotp"
set "PATH=C:\src\flutter\bin;C:\Program Files\Git\cmd;%PATH%"

echo 1. Dang dong cac tien trinh bi ket (Dart, Flutter, Chrome)...
taskkill /F /IM dart.exe /T >nul 2>&1
taskkill /F /IM flutter.exe /T >nul 2>&1
taskkill /F /IM chrome.exe /T >nul 2>&1

echo 2. Dang mo ung dung tren Chrome...
echo (Vui long cho trong giay lat...)
call flutter run -d chrome

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [LOI] Khong the khoi chay tu dong. 
    echo Ban hay thu RESTART may tinh va chay lai file nay nhe!
)

pause
