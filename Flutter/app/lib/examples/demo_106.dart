import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '状态管理参考',
      summary: '常见方案：setState、InheritedWidget、Provider、Riverpod、Bloc…按复杂度选型。',
      children: [
        TopicSection(
          title: '方案对照（概念）',
          child: Column(
            children: [
              for (final row in [
                ('setState', '单页 / 局部'),
                ('InheritedWidget', '轻量下发'),
                ('Provider / Riverpod', '依赖注入 + 监听'),
                ('Bloc / Cubit', '事件驱动'),
              ])
                ListTile(
                  dense: true,
                  title: Text(row.$1),
                  subtitle: Text(row.$2),
                  trailing: Icon(Icons.check_circle_outline, color: Theme.of(context).colorScheme.primary),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
