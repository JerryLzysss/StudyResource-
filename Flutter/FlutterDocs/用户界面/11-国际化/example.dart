import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  Locale locale = const Locale('zh');

  String t(String zh, String en) => locale.languageCode == 'zh' ? zh : en;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '国际化 (i18n)',
      summary: '国际化：为文案提供多语言；用 Localizations / intl / arb 管理。此处用简易切换示意。',
      children: [
        TopicSection(
          title: '切换语言',
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'zh', label: Text('中文')),
              ButtonSegment(value: 'en', label: Text('English')),
            ],
            selected: {locale.languageCode},
            onSelectionChanged: (s) => setState(() => locale = Locale(s.first)),
          ),
        ),
        TopicSection(
          title: '文案',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t('你好，世界', 'Hello, World'), style: Theme.of(context).textTheme.headlineSmall),
              Text(t('欢迎使用 Flutter 文档示例', 'Welcome to Flutter docs demos')),
              const SizedBox(height: 8),
              FilledButton(onPressed: () {}, child: Text(t('开始', 'Get started'))),
            ],
          ),
        ),
        const TopicSection(
          title: '工程做法',
          child: TopicCode('flutter gen-l10n\nMaterialApp(localizationsDelegates: …, supportedLocales: …)'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
