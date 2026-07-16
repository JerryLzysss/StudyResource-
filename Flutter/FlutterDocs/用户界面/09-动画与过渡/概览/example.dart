import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> with SingleTickerProviderStateMixin {
  late final AnimationController c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat(reverse: true);
  late final Animation<double> scale = Tween(begin: 0.8, end: 1.2).animate(CurvedAnimation(parent: c, curve: Curves.easeInOut));

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '概览',
      summary: '显式动画：Controller + Tween；隐式动画：Animated* widget。',
      children: [
        TopicSection(
          title: 'ScaleTransition',
          child: Center(
            child: ScaleTransition(
              scale: scale,
              child: const FlutterLogo(size: 96),
            ),
          ),
        ),
        const TopicSection(
          title: '对照',
          child: TopicCode('隐式: AnimatedContainer\n显式: AnimationController + Tween\n共享元素: Hero'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
