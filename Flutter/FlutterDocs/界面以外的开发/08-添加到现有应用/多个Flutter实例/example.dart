import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String mode = 'single';


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '多个 Flutter 实例',
      summary: '多 FlutterEngine 成本高；优先复用引擎或 FlutterEngineGroup。',
      children: [
        TopicSection(
          title: '引擎策略',
          child: Column(
            children: [
              RadioListTile<String>(
                title: const Text('单引擎复用'),
                subtitle: const Text('推荐 · 省内存'),
                value: 'single',
                groupValue: mode,
                onChanged: (v) => setState(() => mode = v!),
              ),
              RadioListTile<String>(
                title: const Text('多实例 / 多引擎'),
                subtitle: const Text('隔离强 · 更耗资源'),
                value: 'multi',
                groupValue: mode,
                onChanged: (v) => setState(() => mode = v!),
              ),
              Text(mode == 'single' ? 'Host ↔ 共享 Engine ↔ 多个入口' : 'Host ↔ EngineA + EngineB …'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
