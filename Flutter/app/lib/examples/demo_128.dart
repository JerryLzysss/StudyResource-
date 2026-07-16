import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool useFake = true;
  String message = 'fake: hello';


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '依赖注入',
      summary: '依赖注入：上层不 new 具体实现，便于测试时替换 Fake。',
      children: [
        TopicSection(
          title: '切换 Repository 实现',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SwitchListTile(
                title: Text(useFake ? 'FakeRepo（测试）' : 'ApiRepo（生产）'),
                value: useFake,
                onChanged: (v) => setState(() {
                  useFake = v;
                  message = useFake ? 'fake: hello' : 'api: hello from server';
                }),
              ),
              FilledButton(
                onPressed: () => setState(() {
                  message = useFake ? 'fake: hello #${DateTime.now().second}' : 'api: hello #${DateTime.now().second}';
                }),
                child: const Text('repo.fetch()'),
              ),
              const SizedBox(height: 8),
              TopicCode(message),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
