import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool builder = true;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '性能优化',
      summary: '长列表用 builder；减小重建；避免过深透明度与巨大图片。',
      children: [
        TopicSection(
          title: 'ListView 策略',
          child: Column(
            children: [
              SwitchListTile(
                title: Text(builder ? 'ListView.builder（懒加载）' : '一次性 children'),
                value: builder,
                onChanged: (v) => setState(() => builder = v),
              ),
              SizedBox(
                height: 180,
                child: builder
                    ? ListView.builder(itemCount: 1000, itemBuilder: (_, i) => ListTile(dense: true, title: Text('lazy $i')))
                    : ListView(children: [for (var i = 0; i < 60; i++) ListTile(dense: true, title: Text('eager $i'))]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
