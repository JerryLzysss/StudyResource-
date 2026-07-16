import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '添加一个 Flutter Fragment',
      summary: 'Android 可用 FlutterFragment 嵌入现有 Activity 的一部分区域。',
      children: [
        TopicSection(
          title: 'Activity 内嵌 Fragment 示意',
          child: Container(
            height: 240,
            decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Container(height: 40, color: Colors.blueGrey.shade100, alignment: Alignment.center, child: const Text('Native AppBar')),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Container(color: Colors.grey.shade200, alignment: Alignment.center, child: const Text('Native'))),
                      Expanded(
                        child: Container(
                          color: Colors.blue.shade50,
                          alignment: Alignment.center,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [FlutterLogo(), Text('FlutterFragment')],
                          ),
                        ),
                      ),
                    ],
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
