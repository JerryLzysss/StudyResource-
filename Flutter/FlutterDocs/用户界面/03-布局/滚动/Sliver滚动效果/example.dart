import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Sliver 滚动效果 — CustomScrollView + SliverAppBar + SliverList + SliverGrid
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '使用 Sliver 实现各种酷炫滚动效果',
      summary: 'CustomScrollView 可组合多种 Sliver：可折叠顶栏、列表、网格等在同一滚动视图中。',
      children: [
        TopicSection(
          title: 'CustomScrollView 预览（向下滑）',
          child: SizedBox(
            height: 360,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 120,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text('SliverAppBar'),
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.indigo.shade300, Colors.blue.shade700]),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.orange.shade50,
                    child: const Text('SliverToBoxAdapter：放入普通 widget'),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => ListTile(title: Text('SliverList 项 ${i + 1}')),
                    childCount: 6,
                  ),
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => Container(
                      color: Colors.teal.shade100,
                      alignment: Alignment.center,
                      child: Text('G${i + 1}'),
                    ),
                    childCount: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
