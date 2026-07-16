import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '数据调用 & 后端',
      summary: '涵盖状态管理、网络、序列化、本地持久化，以及 Firebase / Google API 等后端能力。',
      children: [
        TopicSection(
          title: '本模块地图',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final e in [
                ('状态管理', Icons.account_tree),
                ('网络请求', Icons.cloud),
                ('JSON', Icons.data_object),
                ('本地存储', Icons.storage),
                ('Firebase', Icons.local_fire_department),
              ])
                Chip(avatar: Icon(e.$2, size: 16), label: Text(e.$1)),
            ],
          ),
        ),
        const TopicSection(
          title: '实践顺序',
          child: TopicBulletList([
            '先理清短暂状态 vs 应用状态',
            '再用 Future / Stream 对接网络',
            '需要离线时再引入 KV / 文件 / SQLite',
          ]),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
