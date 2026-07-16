import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// 浮动顶栏 — floating / snap SliverAppBar
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '在列表开头添加一个浮动的顶栏',
      summary: 'SliverAppBar(floating: true, snap: true)：向下滚动时顶栏可快速浮现。',
      children: [
        TopicSection(
          title: '浮动顶栏（先上滑隐藏，再轻微下滑浮出）',
          child: SizedBox(
            height: 360,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  title: const Text('浮动顶栏'),
                  backgroundColor: Colors.deepPurple,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => ListTile(
                      leading: CircleAvatar(child: Text('${i + 1}')),
                      title: Text('内容 ${i + 1}'),
                      subtitle: const Text('继续滚动体验 floating + snap'),
                    ),
                    childCount: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
        const TopicSection(
          title: '参数对照',
          child: TopicCode('SliverAppBar(\n  floating: true, // 向下滑时浮出\n  snap: true,     // 吸附展开/收起\n  pinned: false,\n)'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
