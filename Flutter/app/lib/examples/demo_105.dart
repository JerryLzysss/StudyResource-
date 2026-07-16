import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int count = 0;
  final vn = ValueNotifier<int>(0);

  @override
  void dispose() {
    vn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '简单的状态管理',
      summary: '简单场景：状态放在共同祖先，用构造函数或回调下发；不必一上来引入框架。',
      children: [
        TopicSection(
          title: '父持有、子展示',
          child: Column(
            children: [
              Text('$count', style: Theme.of(context).textTheme.displaySmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CounterBtn(label: '-', onTap: () => setState(() => count--)),
                  const SizedBox(width: 12),
                  _CounterBtn(label: '+', onTap: () => setState(() => count++)),
                ],
              ),
            ],
          ),
        ),
        TopicSection(
          title: 'ValueNotifier',
          child: ValueListenableBuilder<int>(
            valueListenable: vn,
            builder: (_, v, __) => ListTile(
              title: Text('notifier = $v'),
              trailing: IconButton(icon: const Icon(Icons.add), onPressed: () => vn.value++),
            ),
          ),
        ),
      ],
    );
  }
}

class _CounterBtn extends StatelessWidget {
  const _CounterBtn({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) =>
      FilledButton(onPressed: onTap, child: Text(label));
}

Widget buildDemo() => const DemoPage();
