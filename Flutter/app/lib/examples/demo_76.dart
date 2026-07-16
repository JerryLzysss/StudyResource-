import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('在页面上添加抽屉')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('菜单', style: TextStyle(fontSize: 22))),
            ListTile(leading: const Icon(Icons.home), title: const Text('首页'), onTap: () => Navigator.pop(context)),
            ListTile(leading: const Icon(Icons.settings), title: const Text('设置'), onTap: () => Navigator.pop(context)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('在页面上添加抽屉', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text('Scaffold.drawer 提供侧滑菜单；点左上角或从边缘滑入。', style: TextStyle(height: 1.5)),
          const SizedBox(height: 16),
          Builder(
            builder: (ctx) => FilledButton(
              onPressed: () => Scaffold.of(ctx).openDrawer(),
              child: const Text('打开抽屉'),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildDemo() => const DemoPage();
