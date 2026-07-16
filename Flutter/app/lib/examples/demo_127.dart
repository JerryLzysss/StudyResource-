import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '数据层',
      summary: '数据层：Repository 聚合 API / 缓存 / DB，对外提供领域模型。',
      children: [
        TopicSection(
          title: 'Repository 扇入',
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _src(context, 'Remote API')),
                  Expanded(child: _src(context, 'Local DB')),
                  Expanded(child: _src(context, 'Cache')),
                ],
              ),
              const Icon(Icons.arrow_downward),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: const Text('UserRepository.getProfile()', textAlign: TextAlign.center),
              ),
              const Icon(Icons.arrow_downward),
              const Text('→ UI / ViewModel'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _src(BuildContext context, String t) => Container(
  margin: const EdgeInsets.all(4),
  padding: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    border: Border.all(color: Theme.of(context).dividerColor),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text(t, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
);

Widget buildDemo() => const DemoPage();
