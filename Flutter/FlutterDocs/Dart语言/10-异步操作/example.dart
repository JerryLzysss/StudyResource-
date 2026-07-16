import 'dart:async';

import 'package:flutter/material.dart';

/// 异步 — Future / async·await / Stream

Future<String> fetchData() async {
  await Future.delayed(const Duration(seconds: 1));
  return '数据获取成功';
}

Stream<int> countStream() async* {
  for (var i = 1; i <= 5; i++) {
    await Future.delayed(const Duration(milliseconds: 400));
    yield i;
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String _futureLog = '尚未开始';
  bool _loading = false;
  final List<int> _streamValues = [];
  StreamSubscription<int>? _sub;
  String _waitLog = '';

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> _runFuture() async {
    setState(() {
      _loading = true;
      _futureLog = '开始获取数据...';
    });
    try {
      final data = await fetchData();
      if (!mounted) return;
      setState(() => _futureLog = '获取到的数据: $data');
    } catch (e) {
      if (!mounted) return;
      setState(() => _futureLog = '错误: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _runStream() {
    _sub?.cancel();
    setState(() => _streamValues.clear());
    _sub = countStream().listen(
      (v) => setState(() => _streamValues.add(v)),
      onDone: () => setState(() {}),
    );
  }

  Future<void> _runWait() async {
    setState(() => _waitLog = 'Future.wait 进行中...');
    final sw = Stopwatch()..start();
    final results = await Future.wait([
      Future.delayed(const Duration(milliseconds: 600), () => 'A'),
      Future.delayed(const Duration(milliseconds: 600), () => 'B'),
      Future.delayed(const Duration(milliseconds: 600), () => 'C'),
    ]);
    sw.stop();
    if (!mounted) return;
    setState(() => _waitLog = '结果=$results · 耗时 ${sw.elapsedMilliseconds}ms（并发约 600ms）');
  }

  @override
  Widget build(BuildContext context) {
    return DartDemoFrame(
      title: '异步操作',
      subtitle: 'Future、async/await 与 Stream',
      children: [
        DemoSection(
          title: 'Future + async/await',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine("Future<String> fetchData() async {\n  await Future.delayed(...);\n  return '数据获取成功';\n}"),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: _loading ? null : _runFuture,
                child: Text(_loading ? '加载中...' : 'await fetchData()'),
              ),
              const SizedBox(height: 8),
              Text(_futureLog),
            ],
          ),
        ),
        DemoSection(
          title: 'Stream：$_streamValues',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine('Stream<int> countStream() async* { yield i; }'),
              const SizedBox(height: 8),
              FilledButton(onPressed: _runStream, child: const Text('监听 countStream()')),
            ],
          ),
        ),
        DemoSection(
          title: 'Future.wait 并发',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine('await Future.wait([f1, f2, f3]);'),
              const SizedBox(height: 8),
              FilledButton(onPressed: _runWait, child: const Text('并发等待三个 Future')),
              if (_waitLog.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(_waitLog),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();

// --- 本地预览用 UI 辅助（与 demo_app 中 dart_demo_frame 一致）---
/// Dart 示例如统一外框：标题区 + 可滚动内容块。
class DartDemoFrame extends StatelessWidget {
  const DartDemoFrame({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class DemoSection extends StatelessWidget {
  const DemoSection({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class CodeLine extends StatelessWidget {
  const CodeLine(this.code, {super.key});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(code, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
    );
  }
}

