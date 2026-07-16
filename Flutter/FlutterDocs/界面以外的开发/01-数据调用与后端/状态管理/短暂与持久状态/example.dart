import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool ephemeral = false;
  int appCount = 0;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '短暂状态 & 持久状态',
      summary: '短暂状态：仅当前 Widget 关心（动画、勾选）。应用/持久状态：跨页面或需落盘。',
      children: [
        TopicSection(
          title: '短暂：本页 Checkbox',
          child: CheckboxListTile(
            title: const Text('仅本页记得'),
            value: ephemeral,
            onChanged: (v) => setState(() => ephemeral = v ?? false),
          ),
        ),
        TopicSection(
          title: '应用状态：提升到父级计数',
          child: Row(
            children: [
              Text('共享计数 $appCount', style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              FilledButton(onPressed: () => setState(() => appCount++), child: const Text('全局 +1')),
            ],
          ),
        ),
        const TopicSection(
          title: '持久化',
          child: Text('跨启动保存需 shared_preferences / 数据库等（见本模块持久化章节）。'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
