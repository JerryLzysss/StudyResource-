import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

Widget buildDemo() => DocAlignedPanel(
  title: '功能 & 政策',
  summary: '本主题偏指南与清单，示例中用要点对应文档概述。',
  points: const [
          '声明平台能力与隐私用途',
          '按平台裁剪不支持的交互',
          '关注折叠态与多窗口政策',
  ],
  codeHint: '''LayoutBuilder / MediaQuery / OrientationBuilder''',
);
