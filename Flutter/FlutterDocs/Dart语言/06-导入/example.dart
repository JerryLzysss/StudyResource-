import 'dart:math' as math;

import 'package:flutter/material.dart';

/// 导入 — core / package / as / show / hide

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  double _angle = 45;

  @override
  Widget build(BuildContext context) {
    final radians = _angle * math.pi / 180;
    return DartDemoFrame(
      title: '导入',
      subtitle: 'dart: / package: / 相对路径，以及 as · show · hide',
      children: [
        DemoSection(
          title: '别名导入 dart:math as math',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine("import 'dart:math' as math;\nmath.sin / math.pi"),
              Text('sin(${_angle.toStringAsFixed(0)}°) = ${math.sin(radians).toStringAsFixed(4)}'),
              Text('pi ≈ ${math.pi}'),
              Slider(
                value: _angle,
                min: 0,
                max: 360,
                divisions: 72,
                label: '${_angle.round()}°',
                onChanged: (v) => setState(() => _angle = v),
              ),
            ],
          ),
        ),
        const DemoSection(
          title: '导入类型',
          child: CodeLine(
            "import 'dart:async';                 // 核心库\n"
            "import 'package:flutter/material.dart'; // 包\n"
            "import '../utils/helper.dart';       // 相对路径",
          ),
        ),
        const DemoSection(
          title: 'show / hide',
          child: CodeLine(
            "import 'dart:ui' show Color, Paint;\n"
            "import 'dart:io' hide File;",
          ),
        ),
        const DemoSection(
          title: '推荐顺序',
          child: CodeLine('1. dart:\n2. package:flutter\n3. 其他 package:\n4. 相对路径'),
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

