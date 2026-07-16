import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Web 无障碍 — 默认关闭、需 opt-in；完整 DOM/ARIA 行为仅在 Web 运行时可验证。
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final onWeb = kIsWeb;
    return TopicDemoScaffold(
      title: 'Web 无障碍',
      summary: '对应文档：Web 上将 Semantics 树映射为可访问 DOM；'
          '默认关闭，需用户点击隐形按钮或在代码中 ensureSemantics()。',
      children: [
        TopicSection(
          title: '当前运行环境',
          child: Text(
            onWeb
                ? '检测到 Web：可尝试下方开启语义树（刷新后仍受 Flutter Web 机制约束）。'
                : '当前不是 Web 目标。Web 无障碍的 DOM / aria-label 行为请用 '
                    '`flutter run -d chrome` 验证；本页主要说明概念与代码入口。',
          ),
        ),
        TopicSection(
          title: '代码中开启（文档推荐）',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopicCode(
                "import 'package:flutter/semantics.dart';\n\n"
                'void main() {\n'
                '  runApp(const MyApp());\n'
                '  if (kIsWeb) {\n'
                '    SemanticsBinding.instance.ensureSemantics();\n'
                '  }\n'
                '}',
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: onWeb
                    ? () {
                        SemanticsBinding.instance.ensureSemantics();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('已调用 ensureSemantics()')),
                        );
                      }
                    : null,
                child: Text(onWeb ? '调用 ensureSemantics()' : '仅在 Web 上可点'),
              ),
            ],
          ),
        ),
        const TopicSection(
          title: '无法在本示例完整演示的部分',
          child: TopicBulletList([
            '隐形「Enable accessibility」按钮与浏览器 DOM 树反射：依赖 Flutter Web 运行时',
            'Semantic Role / ARIA 细节：见官方文档，需在浏览器开发者工具中查看',
            '性能原因导致默认关闭：行为以部署的 Web 构建为准',
          ]),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
