import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '渐入渐出 widget',
      summary: 'AnimatedOpacity 或 FadeTransition 做显隐渐变。',
      children: [
        TopicSection(
          title: 'AnimatedOpacity',
          child: Column(
            children: [
              AnimatedOpacity(
                opacity: visible ? 1 : 0,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  alignment: Alignment.center,
                  child: const Text('Hello Fade'),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(onPressed: () => setState(() => visible = !visible), child: Text(visible ? '渐出' : '渐入')),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
