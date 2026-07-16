import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final info =
        'size: ${mq.size.width.toStringAsFixed(0)} × ${mq.size.height.toStringAsFixed(0)}\n'
        'devicePixelRatio: ${mq.devicePixelRatio}\n'
        'textScaler: ${mq.textScaler}\n'
        'padding: ${mq.padding}\n'
        'viewInsets: ${mq.viewInsets}';
    return TopicDemoScaffold(
      title: 'SafeArea & MediaQuery',
      summary: 'SafeArea 避开刘海/系统栏；MediaQuery 读取屏幕尺寸、方向、文字缩放等环境信息。',
      children: [
        TopicSection(title: 'MediaQuery 读数', child: TopicCode(info)),
        TopicSection(
          title: 'SafeArea 示意',
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.red.shade100,
                    alignment: Alignment.center,
                    child: const Text('贴边内容'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ColoredBox(
                    color: Colors.green.shade100,
                    child: const SafeArea(
                      child: Center(child: Text('SafeArea 内')),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
