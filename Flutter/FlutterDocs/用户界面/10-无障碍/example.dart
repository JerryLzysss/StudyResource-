import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// 无障碍模块入口 — 对应文档总览：清单、三大方向与法规背景。
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '无障碍 (a11y)',
      summary: '对应官方文档总览：发布前将无障碍清单作为关键标准，Flutter 提供框架级支持。',
      children: [
        const TopicSection(
          title: '文档中的三大方向',
          child: TopicBulletList([
            'UI 设计与样式：大字体、对比度、触控目标',
            '辅助技术：TalkBack / VoiceOver 等屏幕阅读器',
            '测试与检查：扫描器、Inspector、自动化指南检测',
          ]),
        ),
        TopicSection(
          title: '可在代码层体现的能力（示意）',
          child: Semantics(
            label: '演示用无障碍按钮',
            button: true,
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('此按钮带有 Semantics 标签，可供屏幕阅读器朗读')),
                );
              },
              icon: const Icon(Icons.accessibility_new),
              label: const Text('带语义的按钮'),
            ),
          ),
        ),
        const TopicSection(
          title: '说明',
          child: Text(
            '法规（WCAG / EN 301 549 等）与完整检查清单请切换「官方文档」Tab。'
            '子主题页面分别演示样式、辅助技术与测试方式。',
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
