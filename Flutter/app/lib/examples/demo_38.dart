import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

Widget buildDemo() => DocAlignedPanel(
  title: '最佳实践',
  summary: '本主题偏指南与清单，示例中用要点对应文档概述。',
  points: const [
          '先约束后布局',
          '断点保持少量且一致',
          '触控目标与文字缩放一并测试',
          '大屏优先内容而非放大手机 UI',
  ],
  codeHint: '''LayoutBuilder / MediaQuery / OrientationBuilder''',
);
