import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool connected = false;
  final logs = <String>[];


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'WebSocket 通信',
      summary: 'WebSocket 保持长连接，适合聊天、行情等推送。下方模拟连接状态与收发。',
      children: [
        TopicSection(
          title: '会话模拟',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: Icon(connected ? Icons.link : Icons.link_off,
                    color: connected ? Colors.green : Colors.grey),
                title: Text(connected ? '已连接 ws://demo.local' : '未连接'),
                trailing: FilledButton(
                  onPressed: () => setState(() {
                    connected = !connected;
                    if (connected) {
                      logs.add('← connected');
                    } else {
                      logs.add('← closed');
                    }
                  }),
                  child: Text(connected ? '断开' : '连接'),
                ),
              ),
              SizedBox(
                height: 140,
                child: ListView(
                  children: [for (final l in logs) Text(l, style: const TextStyle(fontFamily: 'monospace', fontSize: 12))],
                ),
              ),
              FilledButton(
                onPressed: !connected
                    ? null
                    : () => setState(() {
                          logs.add('→ ping');
                          logs.add('← pong');
                        }),
                child: const Text('发送 ping'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
