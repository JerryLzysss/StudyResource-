import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '大屏幕 & 可折叠设备',
      summary: '大屏可用 NavigationRail / 双栏；窄屏退化为底部导航或抽屉。',
      children: [
        TopicSection(
          title: '按宽度切换壳层',
          child: LayoutBuilder(
            builder: (context, c) {
              final wide = c.maxWidth >= 600;
              if (wide) {
                return SizedBox(
                  height: 220,
                  child: Row(
                    children: [
                      NavigationRail(
                        selectedIndex: 0,
                        onDestinationSelected: (_) {},
                        labelType: NavigationRailLabelType.all,
                        destinations: const [
                          NavigationRailDestination(icon: Icon(Icons.home), label: Text('首页')),
                          NavigationRailDestination(icon: Icon(Icons.search), label: Text('搜索')),
                          NavigationRailDestination(icon: Icon(Icons.person), label: Text('我的')),
                        ],
                      ),
                      const VerticalDivider(width: 1),
                      Expanded(
                        child: Container(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                          alignment: Alignment.center,
                          child: Text('宽屏双栏 · ${c.maxWidth.toStringAsFixed(0)}px'),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Column(
                children: [
                  Container(
                    height: 140,
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    alignment: Alignment.center,
                    child: Text('窄屏单栏 · ${c.maxWidth.toStringAsFixed(0)}px'),
                  ),
                  NavigationBar(
                    selectedIndex: 0,
                    onDestinationSelected: (_) {},
                    destinations: const [
                      NavigationDestination(icon: Icon(Icons.home), label: '首页'),
                      NavigationDestination(icon: Icon(Icons.search), label: '搜索'),
                      NavigationDestination(icon: Icon(Icons.person), label: '我的'),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
