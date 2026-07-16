import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '添加单个 Flutter 页面',
      summary: 'Add-to-app：Flutter module 嵌入既有 Android / iOS 应用，而不是替换整个 App。',
      children: [
        TopicSection(
          title: '宿主 + Flutter',
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.blueGrey.shade100,
                child: const Text('Native Host (Java/Kotlin/Swift/OC)', textAlign: TextAlign.center),
              ),
              const Icon(Icons.swap_vert),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.blue.shade50,
                child: const Column(
                  children: [
                    FlutterLogo(size: 40),
                    Text('Flutter Module'),
                    Text('FlutterActivity / ViewController', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              TopicCode('flutter create -t module my_flutter'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
