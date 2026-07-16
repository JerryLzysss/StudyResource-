import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String last = '尚未手势';
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '为你的应用添加交互',
      summary: '用 GestureDetector / InkWell 等把点击、双击、长按、拖动接到回调。',
      children: [
        TopicSection(
          title: 'GestureDetector',
          child: Column(
            children: [
              GestureDetector(
                onTap: () => setState(() { taps++; last = 'onTap'; }),
                onDoubleTap: () => setState(() => last = 'onDoubleTap'),
                onLongPress: () => setState(() => last = 'onLongPress'),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('点 / 双击 / 长按这里\n累计 tap: $taps'),
                ),
              ),
              const SizedBox(height: 8),
              Text('最近事件: $last'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
