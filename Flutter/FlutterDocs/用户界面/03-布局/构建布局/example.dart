import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// 构建布局 — 经典组合：标题区 + 行按钮 + 描述
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '构建布局',
      summary: '把小部件组合成界面：Column 纵向堆叠，Row 横向排列，用 Padding/Expanded 控制间距与伸缩。',
      children: [
        TopicSection(
          title: '组合示例',
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 120,
                  color: Colors.lightBlue.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.landscape, size: 48, color: Colors.white),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 4),
                  child: Text('湖边小屋', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('瑞士，阿尔卑斯山脚下', style: TextStyle(color: Colors.grey)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _action(Icons.call, '电话'),
                      _action(Icons.near_me, '导航'),
                      _action(Icons.share, '分享'),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Text(
                    '用 Column 组织图片、标题、按钮行与正文；按钮行用 Row + 均分。'
                    '这与官方「构建布局」教程的结构一致。',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget _action(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.blue)),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
