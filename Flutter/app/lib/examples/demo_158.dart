import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int n = 0;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Widget 测试概览',
      summary: 'testWidgets 泵入 Widget 树，用 Finder 断言 UI。',
      children: [
        TopicSection(
          title: '泵入示例',
          child: Card(
            child: ListTile(
              title: const Text('Counter'),
              subtitle: Text('value=$n'),
              trailing: IconButton(icon: const Icon(Icons.add), onPressed: () => setState(() => n++)),
            ),
          ),
        ),
        const TopicSection(
          title: '对应测试',
          child: TopicCode("await tester.pumpWidget(MaterialApp(home: Counter()));\nawait tester.tap(find.byIcon(Icons.add));\nawait tester.pump();\nexpect(find.text('value=1'), findsOneWidget);"),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
