import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/dart_demo_frame.dart';

/// 变量 — 空安全 / late / final·const / wildcard

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String? _nullableName;
  late String _lateDescription;
  bool _lateReady = false;
  final String _finalName = 'Bob';
  static const String _appId = 'com.example.dart';

  @override
  Widget build(BuildContext context) {
    return DartDemoFrame(
      title: '变量',
      subtitle: '空安全、late、final / const 与通配符 _',
      children: [
        DemoSection(
          title: '空安全 String? vs String',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine('String? name;  // 可为 null\nString name;   // 不可为 null'),
              const SizedBox(height: 8),
              Row(
                children: [
                  FilledButton(
                    onPressed: () => setState(() => _nullableName = 'Alice'),
                    child: const Text('赋值为 Alice'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () => setState(() => _nullableName = null),
                    child: const Text('设为 null'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _nullableName == null
                    ? '当前为 null，不能直接调用 .length'
                    : 'name = "$_nullableName"，长度 ${_nullableName!.length}',
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'late 延迟初始化',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine("late String description;\ndescription = 'Feijoada!';"),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => setState(() {
                  _lateDescription = 'Feijoada!';
                  _lateReady = true;
                }),
                child: const Text('初始化 late 变量'),
              ),
              const SizedBox(height: 8),
              Text(_lateReady ? 'description = $_lateDescription' : '尚未初始化，读取会抛 LateInitializationError'),
            ],
          ),
        ),
        DemoSection(
          title: 'final 与 const',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CodeLine("final name = '$_finalName';  // 运行时只能赋一次\nconst appId = '$_appId'; // 编译时常量"),
              const SizedBox(height: 8),
              const Text('final 对象引用不可变，但其字段可能可变；const 深不可变。'),
            ],
          ),
        ),
        const DemoSection(
          title: '通配符 _（Dart 3.7+）',
          child: CodeLine('var _ = 1;\nfor (var _ in list) {}\ncatch (_) { ... }'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
