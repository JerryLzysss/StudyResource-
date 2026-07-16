import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

Widget buildDemo() => DocAlignedPanel(
  title: 'API 概览',
  summary: '动画核心 API：Animation、AnimationController、Tween、Curve、Listener/Status。',
  points: const [
          'AnimationController 驱动 0..1',
          'Tween.animate(controller)',
          'CurvedAnimation 套曲线',
          'AnimatedWidget / AnimatedBuilder 重建',
  ],
  codeHint: '''controller = AnimationController(vsync: this, duration: …);''',
);
