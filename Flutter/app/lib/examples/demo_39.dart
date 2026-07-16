import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

Widget buildDemo() => DocAlignedPanel(
  title: '其他资源',
  summary: '本主题偏指南与清单，示例中用要点对应文档概述。',
  points: const [
          '官方 cookbook / 自适应设计文档',
          'Material 大屏指南',
          '各平台人机界面规范',
  ],
  codeHint: '''LayoutBuilder / MediaQuery / OrientationBuilder''',
);
