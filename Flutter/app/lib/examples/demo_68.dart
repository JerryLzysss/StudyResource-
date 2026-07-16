import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

Widget buildDemo() => DocAlignedPanel(
  title: '播放及暂停视频',
  summary: '播放视频通常使用 video_player 插件；本示例合集不内嵌编解码依赖，要点如下。',
  points: const [
          '添加 video_player 依赖',
          'VideoPlayerController.networkUrl / asset',
          '初始化后用 VideoPlayer + 播放/暂停按钮',
          'dispose 时释放 controller',
  ],
  codeHint: '''final c = VideoPlayerController.networkUrl(Uri.parse(url));\nawait c.initialize();\nc.play();''',
);
