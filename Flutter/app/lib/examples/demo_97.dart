import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// 辅助技术 — Semantics 属代码层；TalkBack/VoiceOver 需在系统开启，无法在示例中完整替代。
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool _showSemanticsOverlay = false;

  @override
  Widget build(BuildContext context) {
    final body = TopicDemoScaffold(
      title: '辅助技术',
      summary: '对应屏幕阅读器与移动辅助：代码侧用 Semantics 暴露语义；'
          'TalkBack / VoiceOver 必须在系统设置中开启后才能真实体验。',
      children: [
        const TopicSection(
          title: '无法仅靠示例「模拟」的部分',
          child: TopicBulletList([
            'Android TalkBack、iOS VoiceOver：需在设备辅助功能中开启',
            '屏幕阅读器手势与桌面快捷键：由操作系统提供，不是 App 内 Widget',
            '请按官方文档步骤开启后，回到本 App 导航验证',
          ]),
        ),
        TopicSection(
          title: '代码层可做：Semantics',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                label: '收藏文章',
                button: true,
                child: IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('已触发：屏幕阅读器应朗读「收藏文章」')),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              const TopicCode(
                "Semantics(\n"
                "  label: '收藏文章',\n"
                "  button: true,\n"
                "  child: IconButton(...),\n"
                ")",
              ),
              const SizedBox(height: 8),
              const Text('纯图标按钮若无 Tooltip/语义，阅读器可能只读出「按钮」。'),
            ],
          ),
        ),
        TopicSection(
          title: '调试叠加层（开发用）',
          child: SwitchListTile(
            title: const Text('显示 SemanticsDebugger'),
            subtitle: const Text('用色块标出语义节点，便于检查，非最终用户界面'),
            value: _showSemanticsOverlay,
            onChanged: (v) => setState(() => _showSemanticsOverlay = v),
          ),
        ),
      ],
    );

    if (!_showSemanticsOverlay) return body;
    return SemanticsDebugger(child: body);
  }
}

Widget buildDemo() => const DemoPage();
