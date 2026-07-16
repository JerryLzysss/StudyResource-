import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '显示 Cupertino Sheet',
      summary: 'iOS 风格可用 showCupertinoModalPopup / sheet；Material 侧常用 showModalBottomSheet。',
      children: [
        TopicSection(
          title: '底部 Sheet',
          child: Wrap(
            spacing: 8,
            children: [
              FilledButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => const SizedBox(
                      height: 180,
                      child: Center(child: Text('Material BottomSheet')),
                    ),
                  );
                },
                child: const Text('Material Sheet'),
              ),
              OutlinedButton(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (_) => CupertinoActionSheet(
                      title: const Text('操作'),
                      actions: [
                        CupertinoActionSheetAction(onPressed: () => Navigator.pop(context), child: const Text('确认')),
                      ],
                      cancelButton: CupertinoActionSheetAction(onPressed: () => Navigator.pop(context), child: const Text('取消')),
                    ),
                  );
                },
                child: const Text('Cupertino ActionSheet'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
