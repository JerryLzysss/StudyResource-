import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

Widget buildDemo() => DocAlignedPanel(
  title: '设置 Web 的 URL 策略',
  summary: '深度链接与 URL 策略需原生工程配置，无法在此完全跑通，对应文档概述如下。',
  points: const [
          'PathUrlStrategy / HashUrlStrategy',
          'flutter_web_plugins 设置',
          '与路由器 path 对齐',
  ],
  codeHint: '''go_router: redirect / deep linking docs''',
);
