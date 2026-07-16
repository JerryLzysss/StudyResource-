import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

Widget buildDemo() => DocAlignedPanel(
  title: '在构建时转换资源',
  summary: '在构建流水线中压缩、生成分辨率或代码生成资源（如 flutter_gen）。',
  points: const [
          'asset 变体与分辨率目录',
          'CI 中压缩图片',
          '代码生成类型安全的 Asset 引用',
  ],
  codeHint: '''flutter:\n  assets:\n    - assets/images/''',
);
