import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool passAdd = false;
  bool passStr = false;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '单元测试概览',
      summary: '纯 Dart test()：无 Widget 绑定，跑得最快。',
      children: [
        TopicSection(
          title: '迷你测试运行器',
          child: Column(
            children: [
              ListTile(
                title: const Text('expect(1+1, 2)'),
                trailing: Icon(passAdd ? Icons.check : Icons.close, color: passAdd ? Colors.green : Colors.red),
              ),
              ListTile(
                title: const Text("expect(String.fromCharCodes([97,98]), 'ab')"),
                trailing: Icon(passStr ? Icons.check : Icons.close, color: passStr ? Colors.green : Colors.red),
              ),
              FilledButton(
                onPressed: () => setState(() {
                  passAdd = 1 + 1 == 2;
                  passStr = 'ab' == 'ab';
                }),
                child: const Text('运行 flutter test（模拟）'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
