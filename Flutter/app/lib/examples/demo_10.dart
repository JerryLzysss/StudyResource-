import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Input — TextField / Checkbox / Slider / Switch 等输入控件效果。
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final _ctl = TextEditingController();
  bool _check = false;
  bool _switch = true;
  double _slider = 40;
  String? _radio = 'a';

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Input',
      summary: '对应输入类 widget：TextField、Checkbox、Radio、Slider、Switch 等。',
      children: [
        TopicSection(
          title: 'TextField',
          child: TextField(
            controller: _ctl,
            decoration: const InputDecoration(
              labelText: '输入内容',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.edit),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
        if (_ctl.text.isNotEmpty)
          TopicSection(title: '当前输入', child: Text(_ctl.text)),
        TopicSection(
          title: 'Checkbox / Switch / Radio',
          child: Column(
            children: [
              CheckboxListTile(
                value: _check,
                onChanged: (v) => setState(() => _check = v ?? false),
                title: const Text('Checkbox'),
              ),
              SwitchListTile(
                value: _switch,
                onChanged: (v) => setState(() => _switch = v),
                title: const Text('Switch'),
              ),
              RadioListTile<String>(
                value: 'a',
                groupValue: _radio,
                onChanged: (v) => setState(() => _radio = v),
                title: const Text('选项 A'),
              ),
              RadioListTile<String>(
                value: 'b',
                groupValue: _radio,
                onChanged: (v) => setState(() => _radio = v),
                title: const Text('选项 B'),
              ),
            ],
          ),
        ),
        TopicSection(
          title: 'Slider: ${_slider.round()}',
          child: Slider(
            value: _slider,
            min: 0,
            max: 100,
            divisions: 20,
            label: '${_slider.round()}',
            onChanged: (v) => setState(() => _slider = v),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
