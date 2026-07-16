import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Styling — Theme / MediaQuery / Padding / Material / DecoratedBox 效果。
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool _dark = false;

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: _dark ? Brightness.dark : Brightness.light,
    );

    return TopicDemoScaffold(
      title: 'Styling',
      summary: '对应样式相关：Theme、Padding、Material、MediaQuery、DefaultTextStyle 等。',
      children: [
        TopicSection(
          title: '局部 Theme',
          child: Theme(
            data: ThemeData(colorScheme: scheme, useMaterial3: true),
            child: Builder(
              builder: (ctx) => Card(
                color: Theme.of(ctx).colorScheme.primaryContainer,
                child: SwitchListTile(
                  title: Text(_dark ? 'Dark ColorScheme' : 'Light ColorScheme'),
                  value: _dark,
                  onChanged: (v) => setState(() => _dark = v),
                ),
              ),
            ),
          ),
        ),
        TopicSection(
          title: 'Padding / Material',
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(12),
            color: Colors.amber.shade100,
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Text('Padding 20 + Material elevation'),
            ),
          ),
        ),
        TopicSection(
          title: 'DefaultTextStyle',
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 18, color: Colors.deepPurple, fontWeight: FontWeight.w600),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('继承默认文字样式'),
                Text('无需每个 Text单独设 style'),
              ],
            ),
          ),
        ),
        TopicSection(
          title: 'MediaQuery 信息',
          child: Builder(
            builder: (ctx) {
              final size = MediaQuery.sizeOf(ctx);
              final pad = MediaQuery.paddingOf(ctx);
              return Text('size=${size.width.toStringAsFixed(0)}×${size.height.toStringAsFixed(0)}  padding.top=${pad.top.toStringAsFixed(0)}');
            },
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
