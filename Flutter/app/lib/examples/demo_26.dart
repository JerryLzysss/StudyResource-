import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// 滚动概览 — 多种滚动容器对比
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '滚动概览',
      summary: 'Flutter 常见滚动容器：SingleChildScrollView、ListView、PageView、CustomScrollView。',
      children: [
        TopicSection(
          title: 'SingleChildScrollView',
          child: SizedBox(
            height: 80,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  10,
                  (i) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Chip(label: Text('标签 $i')),
                  ),
                ),
              ),
            ),
          ),
        ),
        TopicSection(
          title: 'ListView',
          child: SizedBox(
            height: 120,
            child: ListView(
              children: const [
                ListTile(title: Text('可滚动子项 A')),
                ListTile(title: Text('可滚动子项 B')),
                ListTile(title: Text('可滚动子项 C')),
                ListTile(title: Text('可滚动子项 D')),
              ],
            ),
          ),
        ),
        TopicSection(
          title: 'PageView（左右翻页）',
          child: SizedBox(
            height: 100,
            child: PageView(
              children: [
                for (final c in [Colors.cyan, Colors.amber, Colors.deepPurple])
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    color: c.shade200,
                    alignment: Alignment.center,
                    child: const Text('滑动翻页'),
                  ),
              ],
            ),
          ),
        ),
        const TopicSection(
          title: '进阶',
          child: Text('更复杂的吸顶、折叠头图等见 CustomScrollView + Sliver（下一主题）。'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
