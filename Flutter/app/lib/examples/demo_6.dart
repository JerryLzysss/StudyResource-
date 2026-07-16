import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Animation 目录 widget 效果。
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool _big = false;
  bool _visible = true;
  bool _cross = false;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Animation',
      summary: '对应动画类 widget：AnimatedContainer、AnimatedOpacity、AnimatedCrossFade 等。',
      children: [
        TopicSection(
          title: 'AnimatedContainer',
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                width: _big ? 180 : 90,
                height: _big ? 90 : 60,
                decoration: BoxDecoration(
                  color: _big ? Colors.deepPurple : Colors.teal,
                  borderRadius: BorderRadius.circular(_big ? 24 : 8),
                ),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => setState(() => _big = !_big),
                child: const Text('切换尺寸 / 颜色'),
              ),
            ],
          ),
        ),
        TopicSection(
          title: 'AnimatedOpacity',
          child: Column(
            children: [
              AnimatedOpacity(
                opacity: _visible ? 1 : 0.15,
                duration: const Duration(milliseconds: 400),
                child: const FlutterLogo(size: 64),
              ),
              TextButton(
                onPressed: () => setState(() => _visible = !_visible),
                child: Text(_visible ? '变淡' : '显示'),
              ),
            ],
          ),
        ),
        TopicSection(
          title: 'AnimatedCrossFade',
          child: Column(
            children: [
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 400),
                crossFadeState: _cross ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                firstChild: const Icon(Icons.light_mode, size: 56, color: Colors.orange),
                secondChild: const Icon(Icons.dark_mode, size: 56, color: Colors.indigo),
              ),
              TextButton(
                onPressed: () => setState(() => _cross = !_cross),
                child: const Text('交叉淡入淡出'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
