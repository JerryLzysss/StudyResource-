import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '加载网络图片',
      summary: 'Image.network 加载远程图；务必提供 loadingBuilder / errorBuilder。',
      children: [
        TopicSection(
          title: 'Image.network',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://docs.flutter.dev/assets/images/shared/brand/flutter/logo/flutter-opengraph.png',
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (c, child, p) {
                if (p == null) return child;
                return const SizedBox(height: 140, child: Center(child: CircularProgressIndicator()));
              },
              errorBuilder: (c, e, s) => Container(
                height: 140,
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: const Text('加载失败（检查网络）'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
