import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// 混合类型列表
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_Item>[
      _Item.header('今日推荐'),
      _Item.message('Flutter 布局', 'Row / Column / Stack'),
      _Item.message('列表与网格', 'ListView / GridView'),
      _Item.header('进阶'),
      _Item.message('Sliver', 'CustomScrollView'),
      _Item.message('错位滚动', 'PageView + 联动'),
    ];

    return TopicDemoScaffold(
      title: '构建包含不同类型元素的列表',
      summary: '同一列表可混合标题、消息等多种 item；用类型判断返回不同 widget。',
      children: [
        TopicSection(
          title: '混合 ListView',
          child: SizedBox(
            height: 320,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) {
                final item = items[i];
                if (item.isHeader) {
                  return Container(
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  );
                }
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.article, size: 18)),
                  title: Text(item.title),
                  subtitle: Text(item.subtitle!),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _Item {
  _Item.header(this.title)
      : isHeader = true,
        subtitle = null;
  _Item.message(this.title, this.subtitle) : isHeader = false;

  final bool isHeader;
  final String title;
  final String? subtitle;
}

Widget buildDemo() => const DemoPage();
