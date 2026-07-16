import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Painting — Opacity / DecoratedBox / Transform / Clip / CustomPaint 效果。
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  double _opacity = 0.7;
  double _rotate = 0;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Painting',
      summary: '对应绘制类 widget：Opacity、DecoratedBox、Transform、ClipRRect、CustomPaint 等。',
      children: [
        TopicSection(
          title: 'Opacity: ${_opacity.toStringAsFixed(1)}',
          child: Column(
            children: [
              Opacity(
                opacity: _opacity,
                child: Container(
                  height: 56,
                  width: double.infinity,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const Text('半透明蓝色块', style: TextStyle(color: Colors.white)),
                ),
              ),
              Slider(value: _opacity, onChanged: (v) => setState(() => _opacity = v)),
            ],
          ),
        ),
        TopicSection(
          title: 'DecoratedBox / BoxDecoration',
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.purple.shade200, Colors.blue.shade400]),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(blurRadius: 8, offset: Offset(0, 4), color: Colors.black26)],
            ),
            child: const SizedBox(
              height: 72,
              width: double.infinity,
              child: Center(child: Text('渐变 + 圆角 + 阴影', style: TextStyle(color: Colors.white))),
            ),
          ),
        ),
        TopicSection(
          title: 'Transform.rotate',
          child: Column(
            children: [
              Transform.rotate(
                angle: _rotate,
                child: const FlutterLogo(size: 56),
              ),
              Slider(
                value: _rotate,
                min: 0,
                max: 6.28,
                onChanged: (v) => setState(() => _rotate = v),
              ),
            ],
          ),
        ),
        TopicSection(
          title: 'ClipRRect / CustomPaint',
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(width: 72, height: 72, color: Colors.teal, child: const Icon(Icons.person, color: Colors.white, size: 40)),
              ),
              const SizedBox(width: 24),
              CustomPaint(
                size: const Size(72, 72),
                painter: _TrianglePainter(Colors.deepOrange),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  _TrianglePainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget buildDemo() => const DemoPage();
