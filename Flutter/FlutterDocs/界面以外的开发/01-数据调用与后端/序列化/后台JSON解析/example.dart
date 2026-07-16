import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool busy = false;
  String out = '';


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '在后台处理 JSON 解析',
      summary: '大 JSON 用 compute / Isolate.run 解析，避免卡住 UI isolate。',
      children: [
        TopicSection(
          title: '模拟后台解析',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                onPressed: busy
                    ? null
                    : () async {
                        setState(() { busy = true; out = '解析中…'; });
                        await Future<void>.delayed(const Duration(milliseconds: 800));
                        if (!mounted) return;
                        setState(() {
                          busy = false;
                          out = 'Isolate 完成：解析 5000 条记录（模拟）';
                        });
                      },
                child: Text(busy ? '后台运行中…' : 'compute(() => decodeHugeJson)'),
              ),
              const SizedBox(height: 8),
              if (busy) const LinearProgressIndicator(),
              Text(out),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
