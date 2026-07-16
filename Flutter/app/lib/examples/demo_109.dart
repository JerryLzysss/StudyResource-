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
    return '200 OK\nAuthorization: Bearer ${tokenCtrl.text.substring(0, 12)}…\n{"user":"demo"}';
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
      title: '构建需要认证的请求',
      summary: '在 Header 中带 Token / API Key；注意勿把密钥写进客户端仓库。',
      children: [
        TopicSection(
          title: '模拟 GET + Authorization',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              TextField(
                controller: tokenCtrl,
                decoration: const InputDecoration(labelText: 'Bearer token', border: OutlineInputBorder()),
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
                child: Text(loading ? '请求中…' : '执行 GET + Authorization（模拟）'),
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
