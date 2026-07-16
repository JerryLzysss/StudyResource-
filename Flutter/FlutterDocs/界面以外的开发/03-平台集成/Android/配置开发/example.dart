import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final items = const [
    '安装对应平台工具链',
    '接受许可证 / 证书',
    '配置签名或调试描述文件',
    '声明权限与隐私用途',
  ];
  final done = <String>{};


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '配置 Android 开发',
      summary: '在 android/ 或 ios/ 工程中配置 SDK、签名、权限与能力声明。',
      children: [
        TopicSection(
          title: '配置检查清单',
          child: Column(
            children: [
              for (final item in items)
                CheckboxListTile(
                  dense: true,
                  title: Text(item),
                  value: done.contains(item),
                  onChanged: (v) => setState(() {
                    if (v == true) {
                      done.add(item);
                    } else {
                      done.remove(item);
                    }
                  }),
                ),
              Text('完成 ${done.length}/${items.length}'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
