/**
 * 按 registry 标题/模块生成与官方文档主题对齐的 demo_0..192
 * 运行: node tool/regen_topic_demos.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.join(__dirname, '..');
const OUT = path.join(ROOT, 'lib', 'examples');

function loadMeta() {
  const t = fs.readFileSync(path.join(ROOT, 'lib/generated/demo_registry.g.dart'), 'utf8');
  const re =
    /DemoEntry\(\s*id: '([^']+)',\s*section: '([^']+)',\s*sectionFolder: '([^']+)',\s*module: '([^']+)',\s*moduleFolder: '([^']+)',\s*title: '([^']+)',\s*docAsset: '([^']+)',\s*builder: ex_(\d+)/g;
  const rows = [];
  let m;
  while ((m = re.exec(t))) {
    rows.push({
      id: m[1],
      section: m[2],
      sectionFolder: m[3],
      module: m[4],
      moduleFolder: m[5],
      title: m[6],
      doc: m[7],
      n: +m[8],
    });
  }
  return rows;
}

const META = loadMeta();

const kitImport = `import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';\n`;

function esc(s) {
  return String(s).replace(/\\/g, '\\\\').replace(/'/g, "\\'");
}

function docPanel(title, summary, points, codeHint) {
  const pts = points.map((p) => `'${esc(p)}'`).join(',\n          ');
  const code = codeHint
    ? `codeHint: '''${codeHint.replace(/'''/g, "''")}''',`
    : '';
  return `import 'package:flutter/material.dart';
${kitImport}
Widget buildDemo() => DocAlignedPanel(
  title: '${esc(title)}',
  summary: '${esc(summary)}',
  points: const [
          ${pts},
  ],
  ${code}
);
`;
}

function wrapScaffold(title, summary, bodyDart, {stateful = false, extra = ''} = {}) {
  if (!stateful) {
    return `import 'package:flutter/material.dart';
${kitImport}${extra}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(title)}',
      summary: '${esc(summary)}',
      children: [
${bodyDart}
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }
  return `import 'package:flutter/material.dart';
${kitImport}${extra}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
${bodyDart}
}

Widget buildDemo() => const DemoPage();
`;
}

// —— 具体生成器 ——

function genOverview(m) {
  return wrapScaffold(
    m.title,
    '对应官方文档「使用 Flutter 构建界面」：Widget 是 UI 的基本构成单位。',
    `        const TopicSection(
          title: 'Hello, Flutter!',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopicCode("runApp(const Center(\\n  child: Text('Hello, world!', textDirection: TextDirection.ltr),\\n));"),
              SizedBox(height: 8),
              Text('框架用 widget 描述 UI；状态变化时重建描述并 diff 渲染树。'),
            ],
          ),
        ),
        TopicSection(
          title: '本页对应文档',
          child: TopicBulletList(const [
            'Widget 思想与声明式 UI',
            'runApp / 基础 Text、Center',
            '后续可深入布局、交互、主题等章节',
          ]),
        ),`,
  );
}

function genMaterial(m) {
  return wrapScaffold(
    m.title,
    '对应 Material 组件目录：按钮、输入、结构类控件一览。',
    `        TopicSection(
          title: '常用 Material 控件',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton(onPressed: () {}, child: const Text('FilledButton')),
              OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
              const Chip(label: Text('Chip')),
              const CircleAvatar(child: Icon(Icons.person)),
            ],
          ),
        ),
        const TopicSection(
          title: '结构类',
          child: TopicCode('Scaffold / AppBar / Drawer / BottomNavigationBar / FloatingActionButton'),
        ),`,
  );
}

function genCupertino(m) {
  return `import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
${kitImport}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool _on = true;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(m.title)}',
      summary: '对应 Cupertino（iOS 风格）组件目录中的开关、按钮等。',
      children: [
        TopicSection(
          title: 'CupertinoSwitch / Button',
          child: Row(
            children: [
              CupertinoSwitch(value: _on, onChanged: (v) => setState(() => _on = v)),
              const SizedBox(width: 12),
              CupertinoButton.filled(onPressed: () {}, child: const Text('CupertinoButton')),
            ],
          ),
        ),
        const TopicSection(
          title: '文档提示',
          child: Text('完整 Cupertino widget 列表见「官方文档」Tab。'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
}

function genBasics(m) {
  return wrapScaffold(
    m.title,
    '对应基础 Widget：Text、Image、Icon、容器等。',
    `        TopicSection(
          title: 'Text / Icon / Card',
          child: Column(
            children: const [
              ListTile(leading: Icon(Icons.flutter_dash), title: Text('Text + Icon')),
              Card(child: ListTile(title: Text('Card / ListTile'), subtitle: Text('常用信息容器'))),
            ],
          ),
        ),
        const TopicSection(
          title: '相关文档',
          child: TopicCode('Text · Icon · Image · Container · Placeholder'),
        ),`,
  );
}

function genLayout(m) {
  const t = m.title.toLowerCase();
  if (/listview|列表|滚动|grid/.test(t) || /listview|grid/i.test(m.id)) {
    return wrapScaffold(
      m.title,
      '对应布局文档中的滚动列表 / 网格思路。',
      `        TopicSection(
          title: 'ListView 示意',
          child: SizedBox(
            height: 220,
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (_, i) => ListTile(
                leading: CircleAvatar(child: Text('\${i + 1}')),
                title: Text('列表项 \${i + 1}'),
                subtitle: const Text('对应 ListView / 惰性构建'),
              ),
            ),
          ),
        ),`,
    );
  }
  if (/约束|constraint|box/.test(t)) {
    return wrapScaffold(
      m.title,
      '对应「理解约束」：父级下发约束，子级回报尺寸。',
      `        TopicSection(
          title: 'ConstrainedBox 示例',
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 120, maxWidth: 220, minHeight: 48),
              child: Container(
                color: Colors.blue.shade100,
                alignment: Alignment.center,
                child: const Text('受约束的子组件'),
              ),
            ),
          ),
        ),
        const TopicSection(
          title: '要点',
          child: TopicBulletList([
            '约束自上而下传递',
            '尺寸自下而上决定',
            '最终位置由父级对齐决定',
          ]),
        ),`,
    );
  }
  return wrapScaffold(
    m.title,
    '对应布局构建：Row / Column / Expanded / Stack 等组合。',
    `        TopicSection(
          title: 'Row + Expanded',
          child: Row(
            children: [
              Container(width: 56, height: 56, color: Colors.orange.shade200, child: const Center(child: Text('A'))),
              Expanded(child: Container(height: 56, color: Colors.blue.shade200, child: const Center(child: Text('Expanded')))),
              Container(width: 56, height: 56, color: Colors.green.shade200, child: const Center(child: Text('B'))),
            ],
          ),
        ),
        TopicSection(
          title: 'Column / Stack 示意',
          child: SizedBox(
            height: 120,
            child: Stack(
              children: [
                Container(color: Colors.grey.shade200),
                const Align(alignment: Alignment.center, child: Text('Stack 叠放')),
                const Positioned(right: 8, bottom: 8, child: Icon(Icons.layers)),
              ],
            ),
          ),
        ),`,
  );
}

function genResponsive(m) {
  return wrapScaffold(
    m.title,
    '对应自适应 / 响应式：根据宽度切换布局。',
    `        TopicSection(
          title: 'LayoutBuilder',
          child: LayoutBuilder(
            builder: (context, c) {
              final wide = c.maxWidth > 480;
              return Container(
                padding: const EdgeInsets.all(12),
                color: wide ? Colors.teal.shade50 : Colors.orange.shade50,
                child: Text(wide ? '宽屏布局 (>\${480}) · 当前 \${c.maxWidth.toStringAsFixed(0)}' : '窄屏布局 · 当前 \${c.maxWidth.toStringAsFixed(0)}'),
              );
            },
          ),
        ),
        const TopicSection(
          title: '文档要点',
          child: TopicBulletList([
            'MediaQuery / LayoutBuilder / OrientationBuilder',
            '自适应与响应式的目标差异',
            '断点与弹性布局',
          ]),
        ),`,
  );
}

function genTheme(m) {
  return wrapScaffold(
    m.title,
    '对应设计与主题：ColorScheme / TextTheme / 共享样式。',
    `  ThemeMode _mode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    final bright = _mode == ThemeMode.light;
    return TopicDemoScaffold(
      title: '${esc(m.title)}',
      summary: '对应设计与主题：ColorScheme / TextTheme / 共享样式。',
      children: [
        TopicSection(
          title: '切换明暗（局部示意）',
          child: SwitchListTile(
            title: Text(bright ? 'Light' : 'Dark'),
            value: bright,
            onChanged: (v) => setState(() => _mode = v ? ThemeMode.light : ThemeMode.dark),
          ),
        ),
        TopicSection(
          title: '主题色块',
          child: Theme(
            data: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.indigo,
                brightness: bright ? Brightness.light : Brightness.dark,
              ),
              useMaterial3: true,
            ),
            child: Builder(
              builder: (ctx) => Card(
                color: Theme.of(ctx).colorScheme.primaryContainer,
                child: ListTile(
                  title: Text('primaryContainer', style: Theme.of(ctx).textTheme.titleMedium),
                  subtitle: const Text('来自 ColorScheme.fromSeed'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }`,
    { stateful: true },
  );
}

function genGesture(m) {
  return wrapScaffold(
    m.title,
    '对应交互 / 手势：点击、双击、长按、拖动等。',
    `  String _log = '等待手势…';
  Offset _pos = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(m.title)}',
      summary: '对应交互 / 手势：点击、双击、长按、拖动等。',
      children: [
        TopicSection(
          title: 'GestureDetector',
          child: GestureDetector(
            onTap: () => setState(() => _log = 'onTap'),
            onDoubleTap: () => setState(() => _log = 'onDoubleTap'),
            onLongPress: () => setState(() => _log = 'onLongPress'),
            onPanUpdate: (d) => setState(() {
              _pos += d.delta;
              _log = 'onPanUpdate \${_pos.dx.toStringAsFixed(0)}, \${_pos.dy.toStringAsFixed(0)}';
            }),
            child: Container(
              height: 160,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(_log, textAlign: TextAlign.center),
            ),
          ),
        ),
        const TopicSection(
          title: '文档对应',
          child: TopicCode('GestureDetector / InkWell / Listener\\nPointer 事件 → Gesture 竞技场'),
        ),
      ],
    );
  }`,
    { stateful: true },
  );
}

function genForm(m) {
  return wrapScaffold(
    m.title,
    '对应表单与输入：TextField / Form / 焦点。',
    `  final _key = GlobalKey<FormState>();
  final _ctl = TextEditingController();

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(m.title)}',
      summary: '对应表单与输入：TextField / Form / 校验。',
      children: [
        TopicSection(
          title: 'Form',
          child: Form(
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  controller: _ctl,
                  decoration: const InputDecoration(labelText: '输入内容', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.isEmpty) ? '不能为空' : null,
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('提交: \${_ctl.text}')));
                    }
                  },
                  child: const Text('校验并提交'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }`,
    { stateful: true },
  );
}

function genNavigation(m) {
  return wrapScaffold(
    m.title,
    '对应导航与路由：Navigator 压栈 / 出栈。完整路由表见官方文档。',
    `        TopicSection(
          title: 'Navigator.push 示意',
          child: FilledButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: const Text('详情页')),
                    body: const Center(child: Text('由 Navigator.push 打开')),
                  ),
                ),
              );
            },
            child: const Text('打开详情页'),
          ),
        ),
        TopicSection(
          title: '本主题与文档',
          child: TopicBulletList(const [
            '命令式 Navigator 与声明式 Router',
            '命名路由 / go_router 等方案见文档',
            'Deep Link / Universal Link 需平台配置（见官方文档 Tab）',
          ]),
        ),`,
  );
}

function genAnimation(m) {
  return wrapScaffold(
    m.title,
    '对应动画与过渡：隐式 / 显式动画。',
    `  bool _big = false;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(m.title)}',
      summary: '对应动画与过渡：AnimatedContainer 等隐式动画。',
      children: [
        TopicSection(
          title: 'AnimatedContainer',
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                width: _big ? 200 : 100,
                height: _big ? 120 : 80,
                decoration: BoxDecoration(
                  color: _big ? Colors.purple : Colors.teal,
                  borderRadius: BorderRadius.circular(_big ? 24 : 8),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(onPressed: () => setState(() => _big = !_big), child: const Text('切换')),
            ],
          ),
        ),
        const TopicSection(
          title: '文档对应',
          child: TopicCode('隐式: Animated*\\n显式: AnimationController + Tween\\nHero / PageRouteBuilder'),
        ),
      ],
    );
  }`,
    { stateful: true },
  );
}

function genA11y(m) {
  return wrapScaffold(
    m.title,
    '对应无障碍：Semantics、对比度、屏幕阅读器标签。',
    `        TopicSection(
          title: 'Semantics',
          child: Semantics(
            label: '增加计数按钮',
            button: true,
            child: FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('带语义标签的按钮'),
            ),
          ),
        ),
        const TopicSection(
          title: '文档要点',
          child: TopicBulletList([
            '为可交互控件提供语义标签',
            '足够的颜色对比度',
            '支持放大字体与屏幕阅读器',
          ]),
        ),`,
  );
}

function genI18n(m) {
  return wrapScaffold(
    m.title,
    '对应国际化：按 Locale 切换文案（示意）。完整 ARB/gen_l10n 见官方文档。',
    `  Locale _locale = const Locale('zh');

  @override
  Widget build(BuildContext context) {
    final hi = _locale.languageCode == 'zh' ? '你好' : 'Hello';
    return TopicDemoScaffold(
      title: '${esc(m.title)}',
      summary: '对应国际化：按 Locale 切换文案（示意）。',
      children: [
        TopicSection(
          title: '当前: \$hi',
          child: Wrap(
            spacing: 8,
            children: [
              ChoiceChip(label: const Text('中文'), selected: _locale.languageCode == 'zh', onSelected: (_) => setState(() => _locale = const Locale('zh'))),
              ChoiceChip(label: const Text('English'), selected: _locale.languageCode == 'en', onSelected: (_) => setState(() => _locale = const Locale('en'))),
            ],
          ),
        ),
        const TopicSection(
          title: '文档对应',
          child: TopicCode('flutter_localizations\\ngen-l10n / AppLocalizations\\nMaterialApp.locale'),
        ),
      ],
    );
  }`,
    { stateful: true },
  );
}

function genAssets(m) {
  return wrapScaffold(
    m.title,
    '对应资源与媒体：AssetBundle、图片与字体在 pubspec 中声明。',
    `        const TopicSection(
          title: 'pubspec 声明示意',
          child: TopicCode("flutter:\\n  assets:\\n    - assets/docs/\\n  fonts:\\n    - family: Noto Sans SC\\n      fonts:\\n        - asset: assets/fonts/NotoSansSC-Regular.ttf"),
        ),
        TopicSection(
          title: '本主题',
          child: TopicBulletList(const [
            '图片 / 音频等需列入 assets',
            '使用 Image.asset / rootBundle.loadString',
            '分辨率变体与打包体积见官方文档',
          ]),
        ),`,
  );
}

function genState(m) {
  return wrapScaffold(
    m.title,
    '对应状态管理：短时 UI 状态可用 setState；跨组件共享见文档中的方案对照。',
    `  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(m.title)}',
      summary: '对应状态管理：用 setState 演示局部状态；更大方案见官方文档。',
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _count++),
        child: const Icon(Icons.add),
      ),
      children: [
        TopicSection(
          title: '本地计数: \$_count',
          child: const Text('点击 FAB 触发 setState 重建。'),
        ),
        const TopicSection(
          title: '文档对照',
          child: TopicBulletList([
            '短暂状态 vs 应用状态',
            'setState / InheritedWidget / Provider / Riverpod 等',
            '声明式：UI = f(state)',
          ]),
        ),
      ],
    );
  }`,
    { stateful: true },
  );
}

function genNetwork(m) {
  return wrapScaffold(
    m.title,
    '对应网络请求：用 Future 模拟异步获取（真实 http 包用法见官方文档）。',
    `  late Future<String> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetch();
  }

  Future<String> _fetch() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return '{"message":"ok","topic":"${esc(m.title)}"}';
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(m.title)}',
      summary: '对应网络 / JSON：FutureBuilder 展示异步结果。',
      children: [
        TopicSection(
          title: '模拟请求',
          child: FutureBuilder<String>(
            future: _future,
            builder: (context, snap) {
              if (snap.connectionState != ConnectionState.done) {
                return const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()));
              }
              if (snap.hasError) return Text('错误: \${snap.error}');
              return TopicCode(snap.data ?? '');
            },
          ),
        ),
        TopicSection(
          title: '刷新',
          child: OutlinedButton(
            onPressed: () => setState(() => _future = _fetch()),
            child: const Text('重新请求'),
          ),
        ),
        const TopicSection(
          title: '文档对应',
          child: TopicCode("package:http\\njsonDecode / 模型类\\n错误处理与认证"),
        ),
      ],
    );
  }`,
    { stateful: true },
  );
}

function genPersistence(m) {
  return wrapScaffold(
    m.title,
    '对应本地持久化：键值 / 文件 / SQLite 概念演示（内存模拟）。',
    `  final Map<String, String> _store = {'theme': 'system'};
  final _key = TextEditingController(text: 'theme');
  final _val = TextEditingController(text: 'dark');

  @override
  void dispose() {
    _key.dispose();
    _val.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(m.title)}',
      summary: '对应持久化：此处用内存 Map 模拟 shared_preferences / 文件写入流程。',
      children: [
        TopicSection(
          title: '读写示意',
          child: Column(
            children: [
              TextField(controller: _key, decoration: const InputDecoration(labelText: 'key', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              TextField(controller: _val, decoration: const InputDecoration(labelText: 'value', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              Row(
                children: [
                  FilledButton(
                    onPressed: () => setState(() => _store[_key.text] = _val.text),
                    child: const Text('保存'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () => setState(() => _val.text = _store[_key.text] ?? ''),
                    child: const Text('读取'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('当前存储: \$_store'),
            ],
          ),
        ),
        const TopicSection(
          title: '文档对应',
          child: TopicCode('shared_preferences\\npath_provider + File\\nsqflite'),
        ),
      ],
    );
  }`,
    { stateful: true },
  );
}

function genPerf(m) {
  return wrapScaffold(
    m.title,
    '对应性能优化主题：列表中优先使用 const 与拆分重建范围。',
    `        TopicSection(
          title: 'const 列表项',
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (_, i) => const ListTile(
                leading: Icon(Icons.speed),
                title: Text('优先 const / 缩小 setState 范围'),
              ),
            ),
          ),
        ),
        TopicSection(
          title: '本主题：${esc(m.title)}',
          child: TopicBulletList(const [
            '减少不必要的重建',
            '使用 DevTools Performance / Timeline',
            'Impeller / 应用体积等细节见官方文档 Tab',
          ]),
        ),`,
  );
}

function genDefaultInteractive(m) {
  return wrapScaffold(
    m.title,
    `对应「${esc(m.module)}」中的「${esc(m.title)}」主题，演示与文档概念对齐的最小示例。`,
    `        TopicSection(
          title: '主题卡片',
          child: ListTile(
            leading: const Icon(Icons.menu_book_outlined),
            title: Text('${esc(m.title)}'),
            subtitle: Text('模块：${esc(m.module)}'),
          ),
        ),
        TopicSection(
          title: '学习建议',
          child: TopicBulletList(const [
            '先在本页理解核心 Widget / API 行为',
            '再切换「官方文档」阅读完整说明与代码摘录',
            '可对照文档中的 code-excerpt 自行扩展',
          ]),
        ),`,
  );
}

function genDocOnly(m, points, codeHint) {
  return docPanel(
    m.title,
    `本主题侧重工程配置或平台步骤，示例区列出与「${m.title}」文档对应的要点。`,
    points,
    codeHint,
  );
}

function classify(m) {
  if (m.sectionFolder === 'Dart语言') return null; // skip
  const title = m.title;
  const mod = m.module;
  const folder = m.moduleFolder;
  const id = m.id;
  const blob = `${title} ${mod} ${folder} ${id}`.toLowerCase();

  // Doc-heavy modules
  if (/打包部署|添加到现有|package和插件|应用架构|平台集成/.test(folder) ||
      /flavor|混淆|持续部署|发布|插件|package|架构|platform channel|嵌入|module|fragment|engine/i.test(blob)) {
    if (/测试|调试|性能|状态|网络|json|持久|sqlite|文件|firebase|http|websocket|序列化/.test(blob) &&
        !/打包|发布|添加到|flavor|混淆/.test(blob)) {
      // fall through for data/test/perf
    } else if (/平台集成|package|架构|打包|添加到/.test(folder) || /发布|flavor|混淆|持续部署|添加到|工程设定|嵌入/i.test(blob)) {
      return genDocOnly(m, [
        `文档主题：${title}`,
        `所属模块：${mod}`,
        '请在官方文档 Tab 按步骤操作（IDE / 命令行 / 原生工程）',
        '本示例合集聚焦概念对应，不替代完整工程配置',
      ], title.includes('Android') ? 'flutter build apk / appbundle' : title.includes('iOS') ? 'flutter build ipa' : title.includes('Web') ? 'flutter build web' : '详见官方文档命令与配置');
    }
  }

  if (folder === '01-概览' || title === '概览' && m.sectionFolder === '用户界面' && m.n === 0) return genOverview(m);
  if (/cupertino/i.test(blob)) return genCupertino(m);
  if (/material/i.test(blob)) return genMaterial(m);
  if (/basics|accessibility|input|interaction|assets|async/i.test(title) && /widget目录/i.test(folder)) {
    if (/accessibility/i.test(title)) return genA11y(m);
    if (/input/i.test(title)) return genForm(m);
    return genBasics(m);
  }
  if (/widget目录/.test(folder)) return genBasics(m);
  if (/布局/.test(folder)) return genLayout(m);
  if (/自适应|响应式/.test(folder)) return genResponsive(m);
  if (/设计|主题/.test(folder) || /主题|material.*3|颜色|文字|自定义字体/i.test(blob)) return genTheme(m);
  if (/交互/.test(folder)) {
    if (/表单|输入|焦点|文本字段/i.test(blob)) return genForm(m);
    return genGesture(m);
  }
  if (/资源|媒体/.test(folder)) return genAssets(m);
  if (/导航|路由/.test(folder)) return genNavigation(m);
  if (/动画|过渡/.test(folder)) return genAnimation(m);
  if (/无障碍/.test(folder)) {
    // 无障碍 6 个子主题由手工维护的 demo_94..99 覆盖，避免统一成同一 Semantics 占位
    if (m.n >= 94 && m.n <= 99) return null;
    return genA11y(m);
  }
  if (/国际化/.test(folder) || /i18n|国际化/.test(blob)) return genI18n(m);

  // 界面以外
  if (/状态管理|声明式|provider|inherited|简单的状态|应用状态/i.test(blob)) return genState(m);
  if (/网络|http|获取数据|发送数据|更新数据|删除数据|认证|websocket|json|序列化/i.test(blob)) return genNetwork(m);
  if (/持久|sqlite|文件|键值|shared_preferences/i.test(blob)) return genPersistence(m);
  if (/firebase|google apis/i.test(blob)) {
    return genDocOnly(m, [
      `主题：${title}`,
      '需要额外的 Firebase / Google Cloud 项目与配置文件',
      '官方文档含控制台步骤与 FlutterFire 说明',
    ], 'flutterfire configure');
  }
  if (/性能|impeller|渲染|延迟加载|应用大小|并发|隔离|isolate/i.test(blob) || /性能优化/.test(folder)) return genPerf(m);
  if (/测试|调试|devtools|错误/i.test(blob) || /测试和调试/.test(folder)) {
    return genDocOnly(m, [
      `主题：${title}`,
      '单元测试 / Widget 测试 / 集成测试见官方文档',
      '可在 test/ 目录编写 testWidgets 与 mock',
      '本页展示被测 UI 思路时请结合文档中的Finder API',
    ], "testWidgets('...', (tester) async { ... });");
  }
  if (/数据调用/.test(folder)) return genNetwork(m);

  return genDefaultInteractive(m);
}

let written = 0;
for (const m of META) {
  if (m.n > 192) continue; // keep Dart demos
  const src = classify(m);
  if (!src) continue;
  const file = path.join(OUT, `demo_${m.n}.dart`);
  fs.writeFileSync(file, src, 'utf8');
  written++;
}
console.log(`wrote ${written} demos (0..192)`);
