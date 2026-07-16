import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: TopicDemoScaffold(
        title: '在应用中添加 Tab (标签页切换) 导航',
        summary: 'TabBar + TabBarView（或 NavigationBar）实现标签页切换。',
        children: [
          TopicSection(
            title: 'Tab 导航',
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: '推荐'),
                    Tab(text: '关注'),
                    Tab(text: '我的'),
                  ],
                ),
                SizedBox(
                  height: 160,
                  child: TabBarView(
                    children: [
                      for (final name in ['推荐', '关注', '我的'])
                        Center(child: Text('$name 内容', style: const TextStyle(fontSize: 20))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildDemo() => const DemoPage();
