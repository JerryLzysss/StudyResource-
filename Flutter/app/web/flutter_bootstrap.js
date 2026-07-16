{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  config: {
    // 使用本地 canvaskit，避免从 gstatic.com CDN 加载导致超时
    canvasKitBaseUrl: 'canvaskit/',
  },
  serviceWorkerSettings: {
    serviceWorkerVersion: {{flutter_service_worker_version}},
  },
});
