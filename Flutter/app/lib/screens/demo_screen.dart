import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_docs_demo/models/demo_entry.dart';
import 'package:flutter_docs_demo/utils/doc_sanitize.dart';
import 'package:flutter_docs_demo/utils/doc_typography.dart';
import 'package:flutter_docs_demo/widgets/nested_demo_host.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key, required this.entry});

  final DemoEntry entry;

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _docContent = '加载中...';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadDoc();
  }

  Future<void> _loadDoc() async {
    try {
      final text = await rootBundle.loadString(widget.entry.docAsset);
      if (mounted) setState(() => _docContent = sanitizeDocMarkdown(text));
    } catch (e) {
      if (mounted) setState(() => _docContent = '无法加载文档：${widget.entry.docAsset}\n$e');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entry.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '示例', icon: Icon(Icons.flutter_dash)),
            Tab(text: '官方文档', icon: Icon(Icons.menu_book)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          embedDemoWithoutAppBar(widget.entry.builder(), context),
          Markdown(
            data: _docContent,
            selectable: true,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            styleSheet: docMarkdownStyle(context),
            softLineBreak: true,
          ),
        ],
      ),
    );
  }
}
