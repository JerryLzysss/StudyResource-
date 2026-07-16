import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Async — FutureBuilder / StreamBuilder 效果。
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  late Future<String> _future;
  late Stream<int> _stream;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _future = Future<String>.delayed(const Duration(seconds: 1), () => 'Future 完成 ✓');
    _stream = Stream.periodic(const Duration(milliseconds: 500), (i) => i).take(6);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Async',
      summary: '对应异步 widget：FutureBuilder、StreamBuilder 等，把异步数据反映到 UI。',
      children: [
        TopicSection(
          title: 'FutureBuilder',
          child: Column(
            children: [
              FutureBuilder<String>(
                future: _future,
                builder: (context, snap) {
                  if (snap.connectionState != ConnectionState.done) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Text(snap.data ?? '', style: const TextStyle(fontSize: 18));
                },
              ),
              TextButton(onPressed: _reload, child: const Text('重新加载 Future')),
            ],
          ),
        ),
        TopicSection(
          title: 'StreamBuilder',
          child: StreamBuilder<int>(
            stream: _stream,
            builder: (context, snap) {
              final v = snap.data;
              return Text(
                v == null ? '等待 Stream…' : '收到事件: $v',
                style: const TextStyle(fontSize: 18),
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
