import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

Widget _box(String t, Color c, {double? w, double h = 48}) => Container(
      width: w,
      height: h,
      alignment: Alignment.center,
      color: c,
      child: Text(t, style: const TextStyle(fontSize: 12)),
    );

/// 布局模块入口
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '布局',
      summary: '布局决定子组件如何排布：Row/Column、列表网格、以及 CustomScrollView / Sliver。',
      children: [
        TopicSection(
          title: '基础：Row + Expanded',
          child: Row(
            children: [
              _box('固定', Colors.orange.shade200, w: 56),
              Expanded(child: _box('Expanded 占满剩余', Colors.blue.shade200)),
              _box('固定', Colors.green.shade200, w: 56),
            ],
          ),
        ),
        TopicSection(
          title: '列表 / 网格一瞥',
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: ListView(
                    children: List.generate(4, (i) => ListTile(dense: true, title: Text('列表 $i'))),
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(4, (i) => _box('G$i', Colors.teal.shade100, h: 40)),
                  ),
                ),
              ],
            ),
          ),
        ),
        const TopicSection(
          title: '本模块子主题',
          child: TopicBulletList([
            '构建布局：约束与组合',
            '列表与网格：纵向 / 横向 / Grid / 混合 / 间隔 / 长列表',
            '滚动：Sliver、浮动顶栏、平行错位滚动',
          ]),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
