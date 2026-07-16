import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool dark = false;

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context);
    final themed = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: dark ? Brightness.dark : Brightness.light,
      ),
      useMaterial3: true,
    );
    return TopicDemoScaffold(
      title: '共享主题样式',
      summary: '在 MaterialApp / Theme 中共享 ColorScheme 与 TextTheme；子树用 Theme 或 Theme.of 读取。',
      children: [
        TopicSection(
          title: '切换明暗主题',
          child: SwitchListTile(
            title: Text(dark ? 'Dark' : 'Light'),
            value: dark,
            onChanged: (v) => setState(() => dark = v),
          ),
        ),
        TopicSection(
          title: '局部 Theme',
          child: Theme(
            data: themed,
            child: Builder(
              builder: (ctx) {
                final cs = Theme.of(ctx).colorScheme;
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('primary', style: TextStyle(color: cs.primary, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('onSurface', style: TextStyle(color: cs.onSurface)),
                      const SizedBox(height: 8),
                      FilledButton(onPressed: () {}, child: const Text('使用主题色按钮')),
                      Text('宿主主题 brightness: ${base.brightness}', style: base.textTheme.bodySmall),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
