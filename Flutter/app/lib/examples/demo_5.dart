import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Accessibility 相关 widget 效果（Semantics / ExcludeSemantics / MergeSemantics）。
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Accessibility',
      summary: '对应无障碍相关 widget：Semantics、MergeSemantics、ExcludeSemantics 等。',
      children: [
        TopicSection(
          title: 'Semantics（带标签的图标按钮）',
          child: Semantics(
            label: '收藏',
            button: true,
            child: IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('屏幕阅读器可读「收藏」')),
                );
              },
            ),
          ),
        ),
        TopicSection(
          title: 'MergeSemantics（合并子节点）',
          child: MergeSemantics(
            child: Row(
              children: const [
                Icon(Icons.info_outline),
                SizedBox(width: 8),
                Text('标题与图标合并为一个语义节点'),
              ],
            ),
          ),
        ),
        TopicSection(
          title: 'ExcludeSemantics',
          child: ExcludeSemantics(
            child: Text(
              '这段文字对屏幕阅读器不可见（装饰性内容可排除）',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
        ),
        const TopicSection(
          title: '提示',
          child: Text('完整无障碍实践见「用户界面 → 无障碍」模块；本页聚焦目录中的 a11y widget。'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
