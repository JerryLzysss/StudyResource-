import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  static final _placeholder = MemoryImage(Uint8List.fromList(const [
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
    0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
    0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
    0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
    0x42, 0x60, 0x82,
  ]));

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '从占位图过渡到图片',
      summary: 'FadeInImage 先显示占位，再淡入目标图。',
      children: [
        TopicSection(
          title: 'FadeInImage.memoryNetwork 思路',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FadeInImage(
              placeholder: _placeholder,
              image: const NetworkImage(
                'https://docs.flutter.dev/assets/images/shared/brand/flutter/logo/flutter-opengraph.png',
              ),
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              imageErrorBuilder: (c, e, s) => Container(
                height: 140,
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Text('网络图加载失败'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
