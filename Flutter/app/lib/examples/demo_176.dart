import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int frames = 0;
  bool busy = false;
  String? result;

  @override
  void initState() {
    super.initState();
    Future.doWhile(() async {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      if (!mounted) return false;
      setState(() => frames++);
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '并发与隔离',
      summary: '重计算放到 isolate，避免阻塞 UI；简单场景可用 compute。',
      children: [
        TopicSection(
          title: '阻塞对比（模拟）',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('帧计数动画: $frames'),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: busy
                    ? null
                    : () async {
                        setState(() => busy = true);
                        // 不真正卡死 UI：用分片延迟模拟「后台」完成
                        await Future<void>.delayed(const Duration(milliseconds: 900));
                        if (!mounted) return;
                        setState(() { busy = false; result = 'isolate 完成 heavyWork()'; });
                      },
                child: const Text('Isolate.run(heavyWork)'),
              ),
              if (busy) const LinearProgressIndicator(),
              if (result != null) Text(result!),
              const Text('同时观察上方数字仍在（UI isolate 未死锁）。'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
