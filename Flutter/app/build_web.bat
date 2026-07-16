@echo off
REM 构建离线可用的 Web 包（canvaskit 打包在 build/web 内）
cd /d "%~dp0"
flutter build web --no-web-resources-cdn --release --pwa-strategy=none
echo.
echo 构建完成: build\web
echo 可用任意静态服务器打开，例如:
echo   cd build\web ^&^& python -m http.server 8080
