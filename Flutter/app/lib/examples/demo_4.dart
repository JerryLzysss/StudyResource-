import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Material 组件效果预览。
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool _check = true;
  int _nav = 0;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Material components',
      summary: '对应 Material 3：按钮、选择控件、卡片、导航栏等视觉效果。',
      children: [
        TopicSection(
          title: '按钮',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton(onPressed: () {}, child: const Text('Filled')),
              FilledButton.tonal(onPressed: () {}, child: const Text('Tonal')),
              OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
              TextButton(onPressed: () {}, child: const Text('Text')),
              FloatingActionButton.small(onPressed: () {}, child: const Icon(Icons.add)),
            ],
          ),
        ),
        TopicSection(
          title: '选择与反馈',
          child: Column(
            children: [
              CheckboxListTile(
                value: _check,
                onChanged: (v) => setState(() => _check = v ?? false),
                title: const Text('CheckboxListTile'),
              ),
              SwitchListTile(
                value: _check,
                onChanged: (v) => setState(() => _check = v),
                title: const Text('SwitchListTile'),
              ),
              const LinearProgressIndicator(value: 0.65),
              const SizedBox(height: 8),
              const CircularProgressIndicator(),
            ],
          ),
        ),
        TopicSection(
          title: 'Card / Chip / Avatar',
          child: Column(
            children: [
              const Card(
                child: ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text('ListTile in Card'),
                  subtitle: Text('Material 信息容器'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
              Wrap(
                spacing: 8,
                children: const [
                  Chip(label: Text('Chip')),
                  ActionChip(label: Text('ActionChip'), onPressed: null),
                  FilterChip(label: Text('FilterChip'), selected: true, onSelected: null),
                ],
              ),
            ],
          ),
        ),
        TopicSection(
          title: 'NavigationBar 示意',
          child: NavigationBar(
            selectedIndex: _nav,
            onDestinationSelected: (i) => setState(() => _nav = i),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: '首页'),
              NavigationDestination(icon: Icon(Icons.search), label: '搜索'),
              NavigationDestination(icon: Icon(Icons.person), label: '我的'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
