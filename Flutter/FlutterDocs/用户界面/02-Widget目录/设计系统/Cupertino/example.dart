import 'package:flutter/cupertino.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Cupertino 组件效果预览。
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool _switch = true;
  double _slider = 0.4;
  int _segment = 0;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Cupertino',
      summary: '对应 Cupertino（iOS 风格）组件：开关、滑块、分段控件、按钮等。',
      children: [
        TopicSection(
          title: 'CupertinoSwitch / Slider',
          child: Column(
            children: [
              Row(
                children: [
                  CupertinoSwitch(value: _switch, onChanged: (v) => setState(() => _switch = v)),
                  const SizedBox(width: 12),
                  Text(_switch ? '开' : '关'),
                ],
              ),
              CupertinoSlider(value: _slider, onChanged: (v) => setState(() => _slider = v)),
              Text('Slider: ${_slider.toStringAsFixed(2)}'),
            ],
          ),
        ),
        TopicSection(
          title: 'CupertinoSlidingSegmentedControl',
          child: SizedBox(
            width: double.infinity,
            child: CupertinoSlidingSegmentedControl<int>(
              groupValue: _segment,
              children: const {0: Text('一'), 1: Text('二'), 2: Text('三')},
              onValueChanged: (v) => setState(() => _segment = v ?? 0),
            ),
          ),
        ),
        TopicSection(
          title: 'CupertinoButton',
          child: Wrap(
            spacing: 8,
            children: [
              CupertinoButton(onPressed: () {}, child: const Text('普通')),
              CupertinoButton.filled(onPressed: () {}, child: const Text('Filled')),
            ],
          ),
        ),
        TopicSection(
          title: 'CupertinoActivityIndicator',
          child: const Center(child: CupertinoActivityIndicator(radius: 14)),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
