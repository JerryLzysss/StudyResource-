import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

Widget buildDemo() => DocAlignedPanel(
  title: '设置 iOS Universal Link',
  summary: '深度链接与 URL 策略需原生工程配置，无法在此完全跑通，对应文档概述如下。',
  points: const [
          'Associated Domains',
          'Info.plist',
          'Universal Links 验证',
  ],
  codeHint: '''go_router: redirect / deep linking docs''',
);
