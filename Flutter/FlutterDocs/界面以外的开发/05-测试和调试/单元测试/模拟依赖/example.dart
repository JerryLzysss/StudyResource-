import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool useFake = true;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '模拟依赖',
      summary: '单元测试用 Fake/Mock 替换网络与时钟，断言逻辑而非 IO。',
      children: [
        TopicSection(
          title: 'Clock 依赖替换',
          child: Column(
            children: [
              SwitchListTile(
                title: Text(useFake ? 'FakeClock = 2020-01-01' : '真实 DateTime.now()'),
                value: useFake,
                onChanged: (v) => setState(() => useFake = v),
              ),
              Text('业务看到的「今天」:\n${useFake ? '2020-01-01' : DateTime.now().toIso8601String().substring(0, 10)}',
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
