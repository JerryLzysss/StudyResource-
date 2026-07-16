import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    return TopicDemoScaffold(
      title: '用户输入 & 无障碍 (A11y)',
      summary: '自适应还需考虑触控目标、键盘、指针与文字缩放等无障碍输入场景。',
      children: [
        TopicSection(
          title: '触控目标 ≥ 48',
          child: Row(
            children: [
              IconButton(iconSize: 24, onPressed: () {}, icon: const Icon(Icons.favorite)),
              const SizedBox(width: 8),
              SizedBox(
                width: 48,
                height: 48,
                child: IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
              ),
              const SizedBox(width: 12),
              Text('右侧为推荐最小点击区域', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        TopicSection(
          title: '跟随系统文字缩放',
          child: Text('当前 textScaler: $scaler\n放大系统字体后本行会变大', style: Theme.of(context).textTheme.bodyLarge),
        ),
        TopicSection(
          title: 'Semantics',
          child: Semantics(
            label: '提交订单',
            button: true,
            child: FilledButton(onPressed: () {}, child: const Text('提交')),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
