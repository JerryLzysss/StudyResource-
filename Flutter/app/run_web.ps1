# 本地 Web 运行（不依赖 Google CDN）
Set-Location $PSScriptRoot
flutter run -d chrome --no-web-resources-cdn --pwa-strategy=none @args
