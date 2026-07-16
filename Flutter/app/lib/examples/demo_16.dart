import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Text — Text / RichText / SelectableText / DefaultTextStyle 效果。
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Text',
      summary: '对应文字类 widget：Text、RichText、SelectableText、DefaultTextStyle 等。',
      children: [
        const TopicSection(
          title: 'Text 样式',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('普通 Text'),
              Text('加粗大号', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text('斜体灰色', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
              Text('下划线 + 字间距', style: TextStyle(decoration: TextDecoration.underline, letterSpacing: 2)),
            ],
          ),
        ),
        TopicSection(
          title: 'RichText / TextSpan',
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              children: const [
                TextSpan(text: '一段 '),
                TextSpan(text: '富文本', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                TextSpan(text: '，可混排 '),
                TextSpan(text: '颜色', style: TextStyle(color: Colors.red)),
                TextSpan(text: ' 与 '),
                TextSpan(text: '样式', style: TextStyle(backgroundColor: Colors.yellow)),
                TextSpan(text: '。'),
              ],
            ),
          ),
        ),
        const TopicSection(
          title: 'SelectableText',
          child: SelectableText('这段文字可以长按选择并复制。'),
        ),
        TopicSection(
          title: '溢出处理',
          child: const SizedBox(
            width: 160,
            child: Text(
              '这是一段很长很长很长很长的文字会被截断',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
