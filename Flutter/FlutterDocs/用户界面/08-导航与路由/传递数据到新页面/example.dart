import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '传递数据到新页面',
      summary: 'push 时通过构造函数或 RouteSettings.arguments 传参。',
      children: [
        TopicSection(
          title: '打开详情并传参',
          child: FilledButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: const Text('详情')),
                    body: const Center(child: Text('收到参数: 商品 #42', style: TextStyle(fontSize: 18))),
                  ),
                  settings: const RouteSettings(arguments: 42),
                ),
              );
            },
            child: Text('传入 ID=42'),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
