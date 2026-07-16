import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '通用方法',
      summary: '自适应：同一布局在不同尺寸下仍好用；响应式：随宽度改变布局结构。',
      children: [
        TopicSection(
          title: '断点演示 (LayoutBuilder)',
          child: LayoutBuilder(
            builder: (context, c) {
              final w = c.maxWidth;
              final label = w < 360
                  ? 'compact'
                  : w < 600
                      ? 'medium'
                      : 'expanded';
              final cols = w < 360 ? 1 : w < 600 ? 2 : 3;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('宽度 ${w.toStringAsFixed(0)} → $label · $cols 列'),
                  const SizedBox(height: 8),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: cols,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 2.2,
                    children: List.generate(
                      6,
                      (i) => Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('Item ${i + 1}'),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        TopicSection(
          title: '方向',
          child: OrientationBuilder(
            builder: (context, o) => Text('Orientation.$o'),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
