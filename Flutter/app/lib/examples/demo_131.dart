import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String sel = 'Repository';
  final patterns = <String, String>{
    'Repository': '隐藏数据来源，对上层提供稳定 API。',
    'Observer': 'ValueNotifier / Stream / Listenable 通知 UI。',
    'Command': '把用户操作封装成 Intent / Cubit event。',
    'DI': '构造注入依赖，便于替换实现。',
  };


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '设计模式',
      summary: 'Flutter 常用：组合、观察者、仓库、依赖注入、命令/意图等。',
      children: [
        TopicSection(
          title: '选择模式看说明',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 8,
                children: [
                  for (final p in patterns.keys)
                    ChoiceChip(
                      label: Text(p),
                      selected: sel == p,
                      onSelected: (_) => setState(() => sel = p),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(patterns[sel]!, style: const TextStyle(height: 1.45)),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
