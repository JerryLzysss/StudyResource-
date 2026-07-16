import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  double drag = 0;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '添加预测性返回',
      summary: 'Android 预测性返回：系统手势预览返回目标；Flutter 需启用并正确处理 Pop。',
      children: [
        TopicSection(
          title: '返回手势示意',
          child: Column(
            children: [
              AnimatedSlide(
                offset: Offset(drag, 0),
                duration: const Duration(milliseconds: 50),
                child: Card(
                  child: SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: Center(child: Text(drag > 0.2 ? '即将 pop ←' : '从左缘右滑预览')),
                  ),
                ),
              ),
              Slider(value: drag, onChanged: (v) => setState(() => drag = v)),
              const Text('真实设备由系统驱动；应用侧确保路由可 pop。'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
