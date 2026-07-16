import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool showErr = false;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '处理错误',
      summary: 'FlutterError.onError、PlatformDispatcher.instance.onError 统一上报；UI 用错误状态展示。',
      children: [
        TopicSection(
          title: '安全演示错误区',
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('展示错误占位 UI'),
                value: showErr,
                onChanged: (v) => setState(() => showErr = v),
              ),
              if (showErr)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Column(
                    children: [
                      Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error),
                      const Text('出错了，请重试'),
                      TextButton(onPressed: () => setState(() => showErr = false), child: const Text('重试')),
                    ],
                  ),
                )
              else
                const Text('正常内容'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
