import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// 测试无障碍 — 主要为外部扫描器 / Accessibility Inspector / 自动化测试，非纯 UI 示例。
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocAlignedPanel(
      title: '测试无障碍',
      summary: '本主题对应「如何检查」无障碍：以工具与测试代码为主，'
          '示例 App 内无法替代 Android Accessibility Scanner 或 Xcode Accessibility Inspector。',
      points: const [
        '对照 WCAG 2、EN 301 549 等公开标准；可用 VPAT 做产品自评',
        'Android：安装并启用 Accessibility Scanner，在真机/模拟器上扫描界面',
        'iOS：Xcode → Open Developer Tools → Accessibility Inspector',
        '自动化：在 test/ 中使用 tester.getSemantics / matchesSemantics，'
            '或 guideline 相关断言（详见官方文档）',
        '本页不提供「一键扫描」：扫描器与 Inspector 是独立系统工具',
      ],
      codeHint: '// 测试侧示意（写在 test/*.dart，而非本示例页）\n'
          "testWidgets('button has label', (tester) async {\n"
          '  // await tester.pumpWidget(...);\n'
          '  // expect(tester.getSemantics(find.byType(IconButton)),\n'
          "  //   matchesSemantics(label: '收藏文章', isButton: true));\n"
          '});',
    );
  }
}

Widget buildDemo() => const DemoPage();
