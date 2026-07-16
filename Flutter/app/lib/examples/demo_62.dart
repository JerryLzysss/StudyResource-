import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int n = 0;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '实现快捷方式和捷径',
      summary: 'Shortcuts + Actions + Intent 绑定键盘快捷键；Focus 管理可聚焦控件。',
      children: [
        TopicSection(
          title: 'Ctrl/Cmd + = 增加计数',
          child: Shortcuts(
            shortcuts: const {
              SingleActivator(LogicalKeyboardKey.equal, control: true): _IncIntent(),
              SingleActivator(LogicalKeyboardKey.equal, meta: true): _IncIntent(),
            },
            child: Actions(
              actions: {
                _IncIntent: CallbackAction<_IncIntent>(onInvoke: (_) {
                  setState(() => n++);
                  return null;
                }),
              },
              child: Focus(
                autofocus: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('计数: $n', style: Theme.of(context).textTheme.headlineMedium),
                    const Text('先点本区域获取焦点，再按 Ctrl+=（macOS 用 Cmd+=）'),
                    const SizedBox(height: 8),
                    FilledButton(onPressed: () => setState(() => n++), child: const Text('或点按钮 +1')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _IncIntent extends Intent {
  const _IncIntent();
}

Widget buildDemo() => const DemoPage();
