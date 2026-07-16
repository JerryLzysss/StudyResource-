import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/dart_demo_frame.dart';

/// 注释 — //  /* */  ///

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DartDemoFrame(
      title: '注释',
      subtitle: '单行、多行与文档注释（dartdoc）',
      children: const [
        DemoSection(
          title: '单行注释 //',
          child: CodeLine("// TODO: refactor greeting\nprint('Welcome!');"),
        ),
        DemoSection(
          title: '多行注释 /* */',
          child: CodeLine('/*\n * 暂时禁用的代码块\n * llama.feed();\n */'),
        ),
        DemoSection(
          title: '文档注释 ///',
          child: CodeLine(
            '/// A domesticated South American camelid.\n'
            '///\n'
            '/// Don\'t forget to [feed] them.\n'
            'class Llama {\n'
            '  /// Feeds your llama [food].\n'
            '  void feed(Food food) {}\n'
            '}',
          ),
        ),
        DemoSection(
          title: '提示',
          child: Text('/// 文档注释会被 IDE 与 dartdoc 识别；可用 [链接] 引用同库成员。'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
