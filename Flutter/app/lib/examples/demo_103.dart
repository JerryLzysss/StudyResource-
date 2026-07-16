import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  double temp = 22;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '从声明式的角度思考',
      summary: '声明式：UI = f(state)。改状态，框架重建对应 Widget，而不是命令式改控件。',
      children: [
        TopicSection(
          title: '拖动即重建',
          child: Column(
            children: [
              Text('温度 ${temp.toStringAsFixed(0)}°C', style: Theme.of(context).textTheme.headlineSmall),
              Slider(value: temp, min: -10, max: 40, onChanged: (v) => setState(() => temp = v)),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 72,
                width: double.infinity,
                alignment: Alignment.center,
                color: Color.lerp(Colors.blue, Colors.orange, (temp + 10) / 50)!,
                child: Text(temp < 15 ? '偏冷' : temp < 28 ? '舒适' : '偏热',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              const Text('没有 findViewById / setText——只更新 temp，UI 自动反映。'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
