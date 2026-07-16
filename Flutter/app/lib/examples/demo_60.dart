import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final key = GlobalKey<FormState>();
  String email = '';

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '构建具有校验功能的表单',
      summary: 'Form + TextFormField 做校验；validate / save / reset。',
      children: [
        TopicSection(
          title: '带校验表单',
          child: Form(
            key: key,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: '邮箱', border: OutlineInputBorder()),
                  validator: (v) {
                    if (v == null || v.isEmpty) return '必填';
                    if (!v.contains('@')) return '需包含 @';
                    return null;
                  },
                  onSaved: (v) => email = v ?? '',
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      key.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('已保存: $email')));
                    }
                  },
                  child: const Text('提交'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
