import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '使用自定义的着色器',
      summary: '自定义 Fragment Shader 可做高级视觉效果；此处用 CustomPaint 渐变示意着色思路。',
      children: [
        TopicSection(
          title: 'CustomPaint 渐变（着色示意）',
          child: SizedBox(
            height: 160,
            width: double.infinity,
            child: CustomPaint(painter: _GradientPainter()),
          ),
        ),
        const TopicSection(
          title: '文档要点',
          child: TopicBulletList([
            '将 .frag 放到 shaders/ 并在 pubspec 声明',
            'FragmentProgram.fromAsset 加载',
            '在 CustomPainter / FragmentShader 中设 uniform',
          ]),
        ),
        const TopicSection(
          title: '概念代码',
          child: TopicCode('flutter:\n  shaders:\n    - shaders/myshader.frag'),
        ),
      ],
    );
  }
}

class _GradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(size.width, size.height),
        [const Color(0xFF00695C), const Color(0xFFFFC107), const Color(0xFFE91E63)],
      );
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(12)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget buildDemo() => const DemoPage();
