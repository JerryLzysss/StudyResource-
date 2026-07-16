import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool useM3 = true;
  Color seed = Colors.teal;

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light);
    return TopicDemoScaffold(
      title: '迁移至 Material 3',
      summary: 'Material 3 使用 ColorScheme.fromSeed、动态配色与更新后的组件造型。',
      children: [
        TopicSection(
          title: 'useMaterial3 / 种子色',
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('useMaterial3'),
                value: useM3,
                onChanged: (v) => setState(() => useM3 = v),
              ),
              Wrap(
                spacing: 8,
                children: [
                  for (final entry in [
                    (Colors.teal, 'Teal'),
                    (Colors.indigo, 'Indigo'),
                    (Colors.orange, 'Orange'),
                    (Colors.pink, 'Pink'),
                  ])
                    ChoiceChip(
                      label: Text(entry.$2),
                      selected: seed == entry.$1,
                      onSelected: (_) => setState(() => seed = entry.$1),
                      selectedColor: entry.$1.shade200,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Theme(
                data: ThemeData(colorScheme: scheme, useMaterial3: useM3),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text('M3 预览', style: TextStyle(color: scheme.primary, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        FilledButton(onPressed: () {}, child: const Text('Filled')),
                        const SizedBox(height: 8),
                        OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
