import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Assets — Image / Icon / Asset 展示效果。
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Assets',
      summary: '对应资源相关 widget：Image、Icon、AssetImage 等。本页展示常见用法效果。',
      children: [
        TopicSection(
          title: 'Icon / FlutterLogo',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.image, size: 40, color: Colors.blue),
              FlutterLogo(size: 48),
              Icon(Icons.folder_open, size: 40, color: Colors.orange),
            ],
          ),
        ),
        TopicSection(
          title: 'Image.network（示意）',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://docs.flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png',
              height: 56,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                height: 56,
                alignment: Alignment.center,
                color: Colors.grey.shade200,
                child: const Text('网络图加载失败时显示占位（离线环境正常）'),
              ),
            ),
          ),
        ),
        const TopicSection(
          title: '本地 Asset',
          child: TopicCode(
            "Image.asset('assets/...')\n"
            '需在 pubspec.yaml 的 flutter.assets 中声明路径。',
          ),
        ),
        TopicSection(
          title: 'DecorationImage 背景',
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade600]),
            ),
            alignment: Alignment.center,
            child: const Text('可用 DecorationImage 铺背景图', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
