import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

Widget buildDemo() => DocAlignedPanel(
  title: '设置 Deeplink',
  summary: '深度链接与 URL 策略需原生工程配置，无法在此完全跑通，对应文档概述如下。',
  points: const [
          '统一用路由器声明路径',
          '平台各自注册 scheme / applinks',
          '冷启动与热启动都要处理',
  ],
  codeHint: '''go_router: redirect / deep linking docs''',
);
