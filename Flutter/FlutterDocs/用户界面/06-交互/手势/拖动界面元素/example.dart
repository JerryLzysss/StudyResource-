import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  Color? accepted;
  Offset delta = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '拖动界面元素',
      summary: 'LongPressDraggable + DragTarget 演示拖放；平移可用 onPanUpdate。',
      children: [
        TopicSection(
          title: '拖放到目标',
          child: Row(
            children: [
              LongPressDraggable<Color>(
                data: Colors.teal,
                feedback: Material(
                  elevation: 4,
                  child: Container(width: 64, height: 64, color: Colors.teal.withValues(alpha: 0.8)),
                ),
                childWhenDragging: Container(width: 64, height: 64, color: Colors.grey.shade300),
                child: Container(width: 64, height: 64, color: Colors.teal, alignment: Alignment.center, child: const Text('拖我', style: TextStyle(color: Colors.white))),
              ),
              const SizedBox(width: 24),
              DragTarget<Color>(
                onAcceptWithDetails: (d) => setState(() => accepted = d.data),
                builder: (context, cand, rej) => Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  color: accepted ?? (cand.isNotEmpty ? Colors.teal.shade100 : Colors.grey.shade200),
                  child: Text(accepted == null ? '放到这里' : '已接收'),
                ),
              ),
            ],
          ),
        ),
        TopicSection(
          title: '平移元素',
          child: SizedBox(
            height: 140,
            child: Stack(
              children: [
                Positioned(
                  left: 80 + delta.dx,
                  top: 40 + delta.dy,
                  child: GestureDetector(
                    onPanUpdate: (e) => setState(() => delta += e.delta),
                    onPanEnd: (_) => setState(() => delta = Offset.zero),
                    child: const Chip(label: Text('拖动我'), avatar: Icon(Icons.open_with)),
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
