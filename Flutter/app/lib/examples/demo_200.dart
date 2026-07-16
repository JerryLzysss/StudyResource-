import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/dart_demo_frame.dart';

/// 注解 — @override / @Deprecated / 自定义注解

class Animal {
  String makeSound() => 'Some sound';
}

class Dog extends Animal {
  @override
  String makeSound() => 'Woof!';
}

class Api {
  @Deprecated('请改用 newMethod()')
  String oldMethod() => '旧 API';

  String newMethod() => '新 API';
}

class Todo {
  const Todo(this.message);
  final String message;
}

@Todo('补充单元测试')
void unfinished() {}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final _api = Api();
  String _log = '';

  @override
  Widget build(BuildContext context) {
    return DartDemoFrame(
      title: '注解',
      subtitle: '用 @ 为代码附加元数据：override、deprecated、自定义等',
      children: [
        DemoSection(
          title: '@override：${Dog().makeSound()}',
          child: const CodeLine(
            'class Dog extends Animal {\n'
            '  @override\n'
            '  String makeSound() => \'Woof!\';\n'
            '}',
          ),
        ),
        DemoSection(
          title: '@Deprecated',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine("@Deprecated('Use newMethod()')\nvoid oldMethod() {}"),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // ignore: deprecated_member_use_from_same_package
                      setState(() => _log = '调用: ${_api.oldMethod()}（已废弃）');
                    },
                    child: const Text('oldMethod()'),
                  ),
                  FilledButton(
                    onPressed: () => setState(() => _log = '调用: ${_api.newMethod()}'),
                    child: const Text('newMethod()'),
                  ),
                ],
              ),
              if (_log.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(_log),
              ],
            ],
          ),
        ),
        const DemoSection(
          title: '自定义注解',
          child: CodeLine(
            'class Todo {\n'
            '  const Todo(this.message);\n'
            '  final String message;\n'
            '}\n\n'
            "@Todo('补充单元测试')\n"
            'void unfinished() {}',
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
