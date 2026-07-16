import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> with SingleTickerProviderStateMixin {
  late final AnimationController c =
      AnimationController.unbounded(vsync: this)..addListener(() => setState(() {}));

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  void fling() {
    c.animateWith(
      SpringSimulation(
        const SpringDescription(mass: 1, stiffness: 100, damping: 10),
        c.value,
        120,
        -2000,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final x = c.value.clamp(0, 200).toDouble();
    return TopicDemoScaffold(
      title: '模拟物理特性动画',
      summary: 'SpringSimulation 等物理仿真驱动 AnimationController。',
      children: [
        TopicSection(
          title: '弹簧',
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Stack(
                  children: [
                    Positioned(
                      left: x,
                      child: const CircleAvatar(radius: 24, child: Icon(Icons.sports_baseball)),
                    ),
                  ],
                ),
              ),
              FilledButton(onPressed: fling, child: const Text('弹一下')),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
