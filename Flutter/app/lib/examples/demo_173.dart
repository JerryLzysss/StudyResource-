import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool show = false;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '延迟加载组件',
      summary: '延迟加载：首屏不建昂贵子树；或 deferred import 拆包。',
      children: [
        TopicSection(
          title: '按需构建重列表',
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('加载 500 行列表'),
                value: show,
                onChanged: (v) => setState(() => show = v),
              ),
              if (show)
                SizedBox(
                  height: 220,
                  child: ListView.builder(itemCount: 500, itemBuilder: (_, i) => ListTile(dense: true, title: Text('row $i'))),
                )
              else
                const Text('未加载 → 首帧更轻'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
