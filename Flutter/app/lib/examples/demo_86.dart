import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool on = false;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '过渡 Container 的属性',
      summary: 'AnimatedContainer / AnimatedOpacity 等隐式动画：改属性即可过渡。',
      children: [
        TopicSection(
          title: 'AnimatedContainer',
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 450),
                curve: Curves.easeInOut,
                width: on ? 220 : 100,
                height: on ? 120 : 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: on ? Colors.deepOrange : Colors.teal,
                  borderRadius: BorderRadius.circular(on ? 28 : 8),
                  boxShadow: [
                    BoxShadow(blurRadius: on ? 16 : 4, color: Colors.black26, offset: const Offset(0, 4)),
                  ],
                ),
                child: Text(on ? 'ON' : 'OFF', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              FilledButton(onPressed: () => setState(() => on = !on), child: const Text('切换属性')),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
