import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// 平行错位滚动 — 背景与前景不同速率（简易视差）
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final _controller = ScrollController();
  double _offset = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() => _offset = _controller.offset));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parallax = _offset * 0.4;
    return TopicDemoScaffold(
      title: '构建一个平行错位滚动的效果',
      summary: '前景列表与背景以不同速率移动，形成视差（平行错位）滚动效果。',
      children: [
        TopicSection(
          title: '视差示意（上下滚动）',
          child: SizedBox(
            height: 360,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  // 背景层：移动更慢
                  Positioned(
                    top: -parallax,
                    left: 0,
                    right: 0,
                    height: 420,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue.shade700,
                            Colors.indigo.shade300,
                            Colors.purple.shade200,
                          ],
                        ),
                      ),
                      child: Align(
                        alignment: Alignment(0, -0.6 + (parallax / 400).clamp(-0.3, 0.3)),
                        child: Transform.rotate(
                          angle: parallax / 200,
                          child: Icon(Icons.cloud, size: 80, color: Colors.white.withValues(alpha: 0.35)),
                        ),
                      ),
                    ),
                  ),
                  // 前景列表
                  ListView.builder(
                    controller: _controller,
                    padding: const EdgeInsets.only(top: 140),
                    itemCount: 20,
                    itemBuilder: (_, i) => Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text('前景卡片 ${i + 1}'),
                        subtitle: Text('背景偏移 ${parallax.toStringAsFixed(0)}px（约 0.4× 滚动）'),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Chip(
                      label: Text('offset=${_offset.toStringAsFixed(0)}'),
                      backgroundColor: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        TopicSection(
          title: '说明',
          child: Text(
            '官方教程常用 PageView / NotificationListener 做多层联动；'
            '本示例用 ScrollController 让背景以 ${0.4} 倍速度跟随，直观展示错位。',
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
