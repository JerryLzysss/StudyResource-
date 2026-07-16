import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    Widget layer(String name, Color c) => Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(10)),
      child: Text(name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
    return TopicDemoScaffold(
      title: '架构设计理念',
      summary: '清晰分层、单向数据流、可测试：让功能增长时结构仍可控。',
      children: [
        TopicSection(
          title: '推荐分层',
          child: Column(
            children: [
              layer('UI 层', cs.primaryContainer),
              const Icon(Icons.south),
              layer('领域 / 用例（可选）', cs.secondaryContainer),
              const Icon(Icons.south),
              layer('数据层 Repository', cs.tertiaryContainer),
            ],
          ),
        ),
        TopicSection(
          title: '原则',
          child: TopicBulletList(const [
            'UI 只反映状态，不藏业务副作用',
            '边界明确：网络/DB 不泄漏到 Widget',
            '用接口 + DI 方便测试',
            '按功能分目录，避免「万能 utils」',
          ]),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
