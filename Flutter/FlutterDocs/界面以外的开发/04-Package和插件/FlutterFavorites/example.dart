import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Flutter Favorites 项目',
      summary: 'Flutter Favorites 是社区与团队认可的高质量 package 精选。',
      children: [
        TopicSection(
          title: 'Favorites 示意列表',
          child: Column(
            children: [
              for (final p in ['provider', 'go_router', 'shared_preferences', 'url_launcher', 'flutter_bloc'])
                ListTile(
                  leading: const Icon(Icons.star, color: Colors.amber),
                  title: Text(p),
                  subtitle: const Text('Favorite（示意）'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
