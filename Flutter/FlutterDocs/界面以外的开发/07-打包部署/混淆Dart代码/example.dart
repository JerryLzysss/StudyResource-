import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool on = false;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '混淆 Dart 代码',
      summary: '释放构建可混淆 Dart 符号，减小逆向可读性；需保存 debug info。',
      children: [
        TopicSection(
          title: '符号对照',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SwitchListTile(
                title: const Text('启用 obfuscate'),
                value: on,
                onChanged: (v) => setState(() => on = v),
              ),
              TopicCode(on ? 'a.b.c.X#y\na.b.c.Z#w' : 'MyService.fetchUser()\nHomePageState.build()'),
              const TopicCode('flutter build apk --obfuscate --split-debug-info=build/symbols'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
