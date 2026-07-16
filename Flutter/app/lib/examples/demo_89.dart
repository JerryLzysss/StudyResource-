import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '页面转场动画',
      summary: 'PageRouteBuilder 自定义进入/退出过渡（滑动、淡入等）。',
      children: [
        TopicSection(
          title: '自定义转场',
          child: FilledButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (c, a, s) => Scaffold(
                    appBar: AppBar(title: const Text('新页')),
                    body: const Center(child: Text('从右侧滑入')),
                  ),
                  transitionsBuilder: (c, a, s, child) {
                    final offset = Tween(begin: const Offset(1, 0), end: Offset.zero).animate(a);
                    return SlideTransition(position: offset, child: child);
                  },
                ),
              );
            },
            child: const Text('滑动打开'),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
