import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Hero（跨页面共享元素）动画',
      summary: '相同 tag 的 Hero 在路由切换时共享元素飞跃动画。',
      children: [
        TopicSection(
          title: '点击图片进入详情',
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: const Text('详情')),
                    body: Center(
                      child: Hero(
                        tag: 'hero-demo',
                        child: Icon(Icons.flutter_dash, size: 160, color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Hero(
              tag: 'hero-demo',
              child: Icon(Icons.flutter_dash, size: 72, color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
