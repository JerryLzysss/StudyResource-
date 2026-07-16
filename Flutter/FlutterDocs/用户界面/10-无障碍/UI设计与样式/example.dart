import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// UI 设计与样式 — 大字体、对比度（代码可演示部分）。
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  double _textScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'UI 设计 & 样式',
      summary: '对应文档：大字体适配、足够对比度。可在下方模拟放大文字；系统字体大小需在系统设置中调整。',
      children: [
        TopicSection(
          title: '模拟文字缩放（MediaQuery.textScaler）',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('缩放: ${_textScale.toStringAsFixed(1)}x'),
              Slider(
                value: _textScale,
                min: 1,
                max: 2,
                divisions: 10,
                label: '${_textScale.toStringAsFixed(1)}x',
                onChanged: (v) => setState(() => _textScale = v),
              ),
              MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(_textScale),
                ),
                child: const Card(
                  child: ListTile(
                    title: Text('标题会随缩放变大'),
                    subtitle: Text('请保证布局在最大字号下仍不会溢出或裁切。'),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '系统级字体：iOS「设置 > 无障碍 > 显示与文字大小」；Android「设置 > 字体大小」。'
                '真机用系统设置验证比本页滑条更权威。',
              ),
            ],
          ),
        ),
        TopicSection(
          title: '对比度对比（示意）',
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.yellow.shade100,
                child: const Text(
                  '对比不足示例：浅黄底 + 浅灰字',
                  style: TextStyle(color: Color(0xFFCCCCCC)),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.grey.shade900,
                child: const Text(
                  '对比更好：深色底 + 近白文字',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              const Text('WCAG 对比度要求与计算请见「官方文档」；本页仅作视觉对照。'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
