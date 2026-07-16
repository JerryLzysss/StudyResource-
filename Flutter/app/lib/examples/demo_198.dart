import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/dart_demo_frame.dart';

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
