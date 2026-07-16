import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String flavor = 'dev';


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '为 Android 配置 flavor',
      summary: 'Flavor / 产品风味：同一代码多环境（dev/staging/prod）包名、图标、API。',
      children: [
        TopicSection(
          title: '切换 Flavor',
          child: Column(
            children: [
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'dev', label: Text('dev')),
                  ButtonSegment(value: 'staging', label: Text('staging')),
                  ButtonSegment(value: 'prod', label: Text('prod')),
                ],
                selected: {flavor},
                onSelectionChanged: (s) => setState(() => flavor = s.first),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: flavor == 'prod' ? Colors.green.shade100 : flavor == 'staging' ? Colors.orange.shade100 : Colors.blue.shade100,
                child: Column(
                  children: [
                    Text('App ($flavor)', style: Theme.of(context).textTheme.headlineSmall),
                    Text('api: https://api.$flavor.example.com'),
                    Text('applicationId suffix: .$flavor'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
