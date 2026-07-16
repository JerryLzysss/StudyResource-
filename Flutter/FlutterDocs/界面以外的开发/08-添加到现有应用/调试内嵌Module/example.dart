import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool attached = false;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '调试内嵌的 Flutter module',
      summary: '调试内嵌 module：附加调试器到 Flutter 进程，使用 DevTools。',
      children: [
        TopicSection(
          title: '调试连接示意',
          child: Column(
            children: [
              ListTile(leading: const Icon(Icons.phone_android), title: const Text('Host App'), subtitle: Text(attached ? '已附加' : '未附加')),
              ListTile(leading: const Icon(Icons.flutter_dash), title: const Text('Flutter module'), subtitle: const Text('observatory / VM service')),
              FilledButton(
                onPressed: () => setState(() => attached = !attached),
                child: Text(attached ? '断开调试' : '附加调试器'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
