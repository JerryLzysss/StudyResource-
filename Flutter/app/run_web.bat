@echo off
REM 本地 Web 运行（不依赖 Google CDN）
cd /d "%~dp0"
flutter run -d chrome --no-web-resources-cdn --pwa-strategy=none %*
