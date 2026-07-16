import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final steps = const ['启动 App', '登录', '打开列表', '创建条目'];
  int done = 0;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '编写并运行集成测试',
      summary: '集成测试在真机/模拟器跑完整 App，验证关键用户路径。',
      children: [
        TopicSection(
          title: '关键路径步骤',
          child: Column(
            children: [
              for (var i = 0; i < steps.length; i++)
                CheckboxListTile(
                  title: Text(steps[i]),
                  value: i < done,
                  onChanged: (_) => setState(() => done = i + 1),
                ),
              Text(done >= steps.length ? '全部通过 ✓' : '进度 $done/${steps.length}'),
            ],
          ),
        ),
        const TopicSection(
          title: '命令',
          child: TopicCode('flutter test integration_test/app_test.dart'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
