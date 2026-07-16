import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool loading = false;
  String? result;
  final bodyCtrl = TextEditingController(text: '{"title":"hi"}');
  final tokenCtrl = TextEditingController(text: 'eyJhbGciOi...');

  String _fakeResponse() {
    return '201 Created\n${bodyCtrl.text}';
  }

  @override
  void dispose() {
    bodyCtrl.dispose();
    tokenCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '发送数据到服务器',
      summary: 'POST body（JSON/form）创建资源；检查 201/400。',
      children: [
        TopicSection(
          title: '模拟 POST',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: bodyCtrl,
                decoration: const InputDecoration(labelText: 'JSON body', border: OutlineInputBorder()),
                maxLines: 2,
              ),
              
              const SizedBox(height: 8),
              FilledButton(
                onPressed: loading
                    ? null
                    : () async {
                        setState(() { loading = true; result = null; });
                        await Future<void>.delayed(const Duration(milliseconds: 600));
                        if (!mounted) return;
                        setState(() {
                          loading = false;
                          result = _fakeResponse();
                        });
                      },
                child: Text(loading ? '请求中…' : '执行 POST（模拟）'),
              ),
              const SizedBox(height: 12),
              if (loading) const Center(child: CircularProgressIndicator()),
              if (result != null) TopicCode(result!),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
