import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String eng = 'impeller';


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '使用 Impeller',
      summary: 'Impeller 预编译着色器，减少运行时卡顿；逐步成为默认渲染后端。',
      children: [
        TopicSection(
          title: '渲染后端对照（概念）',
          child: Column(
            children: [
              RadioListTile<String>(
                title: const Text('Impeller'),
                subtitle: const Text('减少 jank · 预编译'),
                value: 'impeller',
                groupValue: eng,
                onChanged: (v) => setState(() => eng = v!),
              ),
              RadioListTile<String>(
                title: const Text('Skia'),
                subtitle: const Text('传统路径 · 运行时编译着色器'),
                value: 'skia',
                groupValue: eng,
                onChanged: (v) => setState(() => eng = v!),
              ),
              Text('当前示意: $eng'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
