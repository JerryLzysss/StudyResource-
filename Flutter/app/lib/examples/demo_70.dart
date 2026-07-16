import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '导航 & 路由',
      summary: 'Navigator.push / pop 做栈式导航；也可用 go_router 声明式路由。',
      children: [
        TopicSection(
          title: '打开新页面',
          child: FilledButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: const Text('第二页')),
                    body: Center(
                      child: FilledButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('返回'),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: const Text('Navigator.push'),
          ),
        ),
        const TopicSection(
          title: '概念',
          child: TopicCode('Navigator.push(context, MaterialPageRoute(...));\nNavigator.pop(context);'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
