import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '寻找 widgets',
      summary: 'WidgetTester 用 find.text / find.byKey / find.byType 定位组件。',
      children: [
        TopicSection(
          title: '被测树',
          child: Column(
            children: [
              Text('Hello', key: const Key('hello')),
              IconButton(key: const Key('fab'), icon: const Icon(Icons.add), onPressed: () {}),
              const FlutterLogo(),
            ],
          ),
        ),
        TopicSection(
          title: 'Finder 结果（模拟）',
          child: Column(
            children: [
              for (final f in [
                ("find.text('Hello')", 'findsOneWidget'),
                ("find.byKey(Key('fab'))", 'findsOneWidget'),
                ("find.byType(FlutterLogo)", 'findsOneWidget'),
                ("find.text('Missing')", 'findsNothing'),
              ])
                ListTile(dense: true, title: Text(f.$1, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)), trailing: Text(f.$2)),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
