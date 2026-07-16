import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  double code = 12;
  double assets = 8;
  double native = 15;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '应用大小',
      summary: '拆分 ABI、压缩资源、延迟组件、去除无用代码，减小安装包。',
      children: [
        TopicSection(
          title: '体积构成（示意 MB）',
          child: Column(
            children: [
              for (final e in [
                ('Dart code', code),
                ('Assets', assets),
                ('Native libs', native),
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      SizedBox(width: 88, child: Text(e.$1)),
                      Expanded(
                        child: LinearProgressIndicator(value: e.$2 / 40, minHeight: 14),
                      ),
                      const SizedBox(width: 8),
                      Text(e.$2.toStringAsFixed(0)),
                    ],
                  ),
                ),
              Text('合计 ~ ${(code + assets + native).toStringAsFixed(0)} MB'),
              Slider(value: assets, min: 2, max: 20, label: 'assets', onChanged: (v) => setState(() => assets = v)),
              const Text('拖动模拟压缩资源后的体积变化'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
