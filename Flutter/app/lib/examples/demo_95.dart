import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// 无障碍概览 — 对应为何要做 a11y 以及 Flutter 支持什么。
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocAlignedPanel(
      title: '概览',
      summary: '本页对应无障碍「概览」文档：背景、法规与 Flutter 提供的框架支持入口。',
      points: const [
        '设计不佳会给各年龄用户制造障碍；应将无障碍列入发版清单',
        'Flutter 在 OS 能力之外提供一流框架支持',
        '下级文档：UI 设计与样式、辅助技术（屏幕阅读器）',
        '常见标准：WCAG 2、EN 301 549；自评可用 VPAT 等资源',
        '本主题以规范与路线图说明为主，无法在页面内「跑通」全部合规检查',
      ],
      codeHint: '下钻文档:\n'
          '/ui/accessibility/ui-design-and-styling\n'
          '/ui/accessibility/assistive-technologies',
    );
  }
}

Widget buildDemo() => const DemoPage();
