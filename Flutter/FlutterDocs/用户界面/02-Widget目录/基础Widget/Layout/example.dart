import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Layout — Align / Expanded / Stack / Wrap / AspectRatio 等效果。
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Layout',
      summary: '对应布局 widget：Row/Column、Expanded、Stack、Align、AspectRatio、Wrap 等。',
      children: [
        TopicSection(
          title: 'Row + Expanded',
          child: Row(
            children: [
              Container(width: 48, height: 48, color: Colors.orange.shade300, child: const Center(child: Text('固'))),
              Expanded(child: Container(height: 48, color: Colors.blue.shade300, child: const Center(child: Text('Expanded')))),
              Container(width: 48, height: 48, color: Colors.green.shade300, child: const Center(child: Text('固'))),
            ],
          ),
        ),
        TopicSection(
          title: 'Stack / Positioned / Align',
          child: SizedBox(
            height: 120,
            child: Stack(
              children: [
                Container(color: Colors.grey.shade200),
                const Align(alignment: Alignment.center, child: Text('Center Align')),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    color: Colors.red.shade300,
                    child: const Text('Positioned'),
                  ),
                ),
              ],
            ),
          ),
        ),
        TopicSection(
          title: 'AspectRatio 16:9',
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.indigo.shade100,
              alignment: Alignment.center,
              child: const Text('16 : 9'),
            ),
          ),
        ),
        TopicSection(
          title: 'Wrap',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              8,
              (i) => Chip(label: Text('Item $i')),
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
