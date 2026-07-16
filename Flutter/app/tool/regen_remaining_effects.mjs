/**
 * 为除 Widget目录(1-16)、布局(17-29)、无障碍(94-99)、Dart(193+) 外的主题
 * 按概述生成可交互效果。运行: node tool/regen_remaining_effects.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.join(__dirname, '..');
const OUT = path.join(ROOT, 'lib', 'examples');
const DOCS = path.join(ROOT, '..', 'FlutterDocs');

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
const kit = `import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';\n`;

function esc(s) {
  return String(s).replace(/\\/g, '\\\\').replace(/'/g, "\\'");
}

function skip(n) {
  if (n >= 1 && n <= 29) return true;
  if (n >= 94 && n <= 99) return true;
  if (n >= 193) return true;
  return false;
}

function docPanel(title, summary, points, codeHint) {
  const pts = points.map((p) => `'${esc(p)}'`).join(',\n          ');
  const code = codeHint
    ? `codeHint: '''${String(codeHint).replace(/'''/g, "''")}''',`
    : '';
  return `import 'package:flutter/material.dart';
${kit}
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

function writeDemo(n, content) {
  fs.writeFileSync(path.join(OUT, `demo_${n}.dart`), content, 'utf8');
}

function syncExample(m, content) {
  // docAsset: assets/docs/用户界面-04-自适应...md → FlutterDocs/用户界面/.../example.dart
  // Prefer matching by walking module folders under FlutterDocs
  const section = m.sectionFolder; // 用户界面 | 界面以外的开发 | Dart语言
  const base = path.join(DOCS, section);
  if (!fs.existsSync(base)) return;

  // Try find README that matches title under moduleFolder
  const mod = path.join(base, m.moduleFolder);
  if (!fs.existsSync(mod)) return;

  // Find example.dart nearest to title: recursive search for folder with matching README title
  function walk(dir) {
    let hits = [];
    for (const ent of fs.readdirSync(dir, { withFileTypes: true })) {
      const p = path.join(dir, ent.name);
      if (ent.isDirectory()) hits = hits.concat(walk(p));
      else if (ent.name === 'README.md') {
        const head = fs.readFileSync(p, 'utf8').slice(0, 200);
        if (head.includes(`# ${m.title}`) || head.includes(m.title)) {
          hits.push(path.join(dir, 'example.dart'));
        }
      }
    }
    return hits;
  }
  const targets = walk(mod);
  for (const t of targets) {
    fs.writeFileSync(t, content, 'utf8');
  }
  // module root example if title equals module
  const rootEx = path.join(mod, 'example.dart');
  if (m.title === m.module || targets.length === 0) {
    if (fs.existsSync(path.join(mod, 'README.md'))) {
      fs.writeFileSync(rootEx, content, 'utf8');
    }
  }
}

// ——— templates ———

function gen0() {
  return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TopicDemoScaffold(
      title: '用户界面 · 概览',
      summary: 'Flutter UI 由 Widget 树构成：布局、主题、交互、导航与动画都在同一套声明式模型里组合。',
      children: [
        TopicSection(
          title: '声明式 UI 一瞥',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('一切皆 Widget', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(avatar: Icon(Icons.widgets, size: 16, color: scheme.primary), label: const Text('Widget')),
                  Chip(avatar: Icon(Icons.view_quilt, size: 16, color: scheme.primary), label: const Text('布局')),
                  Chip(avatar: Icon(Icons.palette, size: 16, color: scheme.primary), label: const Text('主题')),
                  Chip(avatar: Icon(Icons.touch_app, size: 16, color: scheme.primary), label: const Text('交互')),
                  Chip(avatar: Icon(Icons.route, size: 16, color: scheme.primary), label: const Text('导航')),
                  Chip(avatar: Icon(Icons.animation, size: 16, color: scheme.primary), label: const Text('动画')),
                ],
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('从左侧模块进入各主题查看可运行效果')),
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('从下一模块开始探索'),
              ),
            ],
          ),
        ),
        const TopicSection(
          title: '学习路径',
          child: TopicBulletList([
            'Widget 目录 → 认识常用组件',
            '布局 → 约束与滚动',
            '自适应 → MediaQuery / 断点',
            '主题 / 交互 / 导航 / 动画 → 打磨体验',
          ]),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
}

function genAdaptive(m) {
  const t = m.title;
  if (t.includes('SafeArea') || t.includes('MediaQuery')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final info =
        'size: \${mq.size.width.toStringAsFixed(0)} × \${mq.size.height.toStringAsFixed(0)}\\n'
        'devicePixelRatio: \${mq.devicePixelRatio}\\n'
        'textScaler: \${mq.textScaler}\\n'
        'padding: \${mq.padding}\\n'
        'viewInsets: \${mq.viewInsets}';
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'SafeArea 避开刘海/系统栏；MediaQuery 读取屏幕尺寸、方向、文字缩放等环境信息。',
      children: [
        TopicSection(title: 'MediaQuery 读数', child: TopicCode(info)),
        TopicSection(
          title: 'SafeArea 示意',
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.red.shade100,
                    alignment: Alignment.center,
                    child: const Text('贴边内容'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ColoredBox(
                    color: Colors.green.shade100,
                    child: const SafeArea(
                      child: Center(child: Text('SafeArea 内')),
                    ),
                  ),
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
`;
  }

  if (t.includes('大屏幕') || t.includes('可折叠')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
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
                          child: Text('宽屏双栏 · \${c.maxWidth.toStringAsFixed(0)}px'),
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
                    child: Text('窄屏单栏 · \${c.maxWidth.toStringAsFixed(0)}px'),
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
`;
  }

  if (t.includes('用户输入') || t.includes('无障碍')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '自适应还需考虑触控目标、键盘、指针与文字缩放等无障碍输入场景。',
      children: [
        TopicSection(
          title: '触控目标 ≥ 48',
          child: Row(
            children: [
              IconButton(iconSize: 24, onPressed: () {}, icon: const Icon(Icons.favorite)),
              const SizedBox(width: 8),
              SizedBox(
                width: 48,
                height: 48,
                child: IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
              ),
              const SizedBox(width: 12),
              Text('右侧为推荐最小点击区域', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        TopicSection(
          title: '跟随系统文字缩放',
          child: Text('当前 textScaler: \$scaler\\n放大系统字体后本行会变大', style: Theme.of(context).textTheme.bodyLarge),
        ),
        TopicSection(
          title: 'Semantics',
          child: Semantics(
            label: '提交订单',
            button: true,
            child: FilledButton(onPressed: () {}, child: const Text('提交')),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('平台') || t.includes('自动适配')) {
    return `import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isCupertino = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '同一套代码可按平台切换控件风格（Material / Cupertino）与交互习惯。',
      children: [
        TopicSection(
          title: '当前平台',
          child: TopicCode('defaultTargetPlatform = \$defaultTargetPlatform\\nisCupertino-ish = \$isCupertino'),
        ),
        TopicSection(
          title: '自适应按钮示意',
          child: isCupertino
              ? TextButton(onPressed: () {}, child: const Text('Cupertino 风格 TextButton'))
              : FilledButton(onPressed: () {}, child: const Text('Material FilledButton')),
        ),
        TopicSection(
          title: 'Theme 平台密度',
          child: Text('VisualDensity: \${Theme.of(context).visualDensity}'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('功能') || t.includes('政策') || t.includes('其他资源') || t.includes('最佳实践')) {
    return docPanel(
      t,
      '本主题偏指南与清单，示例中用要点对应文档概述。',
      t.includes('最佳')
        ? ['先约束后布局', '断点保持少量且一致', '触控目标与文字缩放一并测试', '大屏优先内容而非放大手机 UI']
        : t.includes('功能')
          ? ['声明平台能力与隐私用途', '按平台裁剪不支持的交互', '关注折叠态与多窗口政策']
          : ['官方 cookbook / 自适应设计文档', 'Material 大屏指南', '各平台人机界面规范'],
      'LayoutBuilder / MediaQuery / OrientationBuilder',
    );
  }

  // 自适应概览 / 通用方法 / 模块入口
  return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '自适应：同一布局在不同尺寸下仍好用；响应式：随宽度改变布局结构。',
      children: [
        TopicSection(
          title: '断点演示 (LayoutBuilder)',
          child: LayoutBuilder(
            builder: (context, c) {
              final w = c.maxWidth;
              final label = w < 360
                  ? 'compact'
                  : w < 600
                      ? 'medium'
                      : 'expanded';
              final cols = w < 360 ? 1 : w < 600 ? 2 : 3;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('宽度 \${w.toStringAsFixed(0)} → \$label · \$cols 列'),
                  const SizedBox(height: 8),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: cols,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 2.2,
                    children: List.generate(
                      6,
                      (i) => Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('Item \${i + 1}'),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        TopicSection(
          title: '方向',
          child: OrientationBuilder(
            builder: (context, o) => Text('Orientation.\$o'),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
}

function genTheme(m) {
  const t = m.title;
  if (t.includes('着色器') || t.includes('shader')) {
    return `import 'dart:ui' as ui;
import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '自定义 Fragment Shader 可做高级视觉效果；此处用 CustomPaint 渐变示意着色思路。',
      children: [
        TopicSection(
          title: 'CustomPaint 渐变（着色示意）',
          child: SizedBox(
            height: 160,
            width: double.infinity,
            child: CustomPaint(painter: _GradientPainter()),
          ),
        ),
        const TopicSection(
          title: '文档要点',
          child: TopicBulletList([
            '将 .frag 放到 shaders/ 并在 pubspec 声明',
            'FragmentProgram.fromAsset 加载',
            '在 CustomPainter / FragmentShader 中设 uniform',
          ]),
        ),
        const TopicSection(
          title: '概念代码',
          child: TopicCode('flutter:\\n  shaders:\\n    - shaders/myshader.frag'),
        ),
      ],
    );
  }
}

class _GradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(size.width, size.height),
        [const Color(0xFF00695C), const Color(0xFFFFC107), const Color(0xFFE91E63)],
      );
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(12)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('自定义字体') || t.includes('package') && t.includes('字体') || t.includes('对外暴露')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '通过 pubspec fonts 声明字体族；package 内字体需指定 package 名。本 App 已嵌入 Noto Sans SC。',
      children: [
        TopicSection(
          title: '默认主题字体',
          child: Text('你好 Flutter — Theme 默认', style: Theme.of(context).textTheme.headlineSmall),
        ),
        const TopicSection(
          title: '显式指定 fontFamily',
          child: Text(
            '你好 Flutter — Noto Sans SC',
            style: TextStyle(fontFamily: 'Noto Sans SC', fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        const TopicSection(
          title: 'pubspec 示意',
          child: TopicCode("flutter:\\n  fonts:\\n    - family: Noto Sans SC\\n      fonts:\\n        - asset: assets/fonts/NotoSansSC-Regular.otf"),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('字体') || t.includes('版式')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'TextTheme 提供 display / headline / title / body / label 层级，保持版式一致。',
      children: [
        TopicSection(
          title: 'TextTheme 层级',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Display Small', style: tt.displaySmall),
              Text('Headline Medium', style: tt.headlineMedium),
              Text('Title Large', style: tt.titleLarge),
              Text('Body Large — 正文示例段落。', style: tt.bodyLarge),
              Text('Label Medium', style: tt.labelMedium),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('Material 3') || t.includes('迁移')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool useM3 = true;
  Color seed = Colors.teal;

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light);
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'Material 3 使用 ColorScheme.fromSeed、动态配色与更新后的组件造型。',
      children: [
        TopicSection(
          title: 'useMaterial3 / 种子色',
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('useMaterial3'),
                value: useM3,
                onChanged: (v) => setState(() => useM3 = v),
              ),
              Wrap(
                spacing: 8,
                children: [
                  for (final entry in [
                    (Colors.teal, 'Teal'),
                    (Colors.indigo, 'Indigo'),
                    (Colors.orange, 'Orange'),
                    (Colors.pink, 'Pink'),
                  ])
                    ChoiceChip(
                      label: Text(entry.\$2),
                      selected: seed == entry.\$1,
                      onSelected: (_) => setState(() => seed = entry.\$1),
                      selectedColor: entry.\$1.shade200,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Theme(
                data: ThemeData(colorScheme: scheme, useMaterial3: useM3),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text('M3 预览', style: TextStyle(color: scheme.primary, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        FilledButton(onPressed: () {}, child: const Text('Filled')),
                        const SizedBox(height: 8),
                        OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  // shared theme / material / overview
  return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool dark = false;

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context);
    final themed = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: dark ? Brightness.dark : Brightness.light,
      ),
      useMaterial3: true,
    );
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '在 MaterialApp / Theme 中共享 ColorScheme 与 TextTheme；子树用 Theme 或 Theme.of 读取。',
      children: [
        TopicSection(
          title: '切换明暗主题',
          child: SwitchListTile(
            title: Text(dark ? 'Dark' : 'Light'),
            value: dark,
            onChanged: (v) => setState(() => dark = v),
          ),
        ),
        TopicSection(
          title: '局部 Theme',
          child: Theme(
            data: themed,
            child: Builder(
              builder: (ctx) {
                final cs = Theme.of(ctx).colorScheme;
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('primary', style: TextStyle(color: cs.primary, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('onSurface', style: TextStyle(color: cs.onSurface)),
                      const SizedBox(height: 8),
                      FilledButton(onPressed: () {}, child: const Text('使用主题色按钮')),
                      Text('宿主主题 brightness: \${base.brightness}', style: base.textTheme.bodySmall),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
}

function genInteraction(m) {
  const t = m.title;
  if (t.includes('手势') || t === '交互' || t.includes('添加交互')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String last = '尚未手势';
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '用 GestureDetector / InkWell 等把点击、双击、长按、拖动接到回调。',
      children: [
        TopicSection(
          title: 'GestureDetector',
          child: Column(
            children: [
              GestureDetector(
                onTap: () => setState(() { taps++; last = 'onTap'; }),
                onDoubleTap: () => setState(() => last = 'onDoubleTap'),
                onLongPress: () => setState(() => last = 'onLongPress'),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('点 / 双击 / 长按这里\\n累计 tap: \$taps'),
                ),
              ),
              const SizedBox(height: 8),
              Text('最近事件: \$last'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('点击')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'InkWell / GestureDetector / IconButton 等处理点击；Material 子树才有水波纹。',
      children: [
        TopicSection(
          title: '多种点击控件',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ElevatedButton'))),
                child: const Text('Elevated'),
              ),
              TextButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('TextButton'))),
                child: const Text('Text'),
              ),
              IconButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('IconButton'))),
                icon: const Icon(Icons.thumb_up),
              ),
              InkWell(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('InkWell'))),
                child: const Padding(padding: EdgeInsets.all(12), child: Text('InkWell 区域')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('拖放') || t.includes('拖动')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  Color? accepted;
  Offset delta = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'LongPressDraggable + DragTarget 演示拖放；平移可用 onPanUpdate。',
      children: [
        TopicSection(
          title: '拖放到目标',
          child: Row(
            children: [
              LongPressDraggable<Color>(
                data: Colors.teal,
                feedback: Material(
                  elevation: 4,
                  child: Container(width: 64, height: 64, color: Colors.teal.withValues(alpha: 0.8)),
                ),
                childWhenDragging: Container(width: 64, height: 64, color: Colors.grey.shade300),
                child: Container(width: 64, height: 64, color: Colors.teal, alignment: Alignment.center, child: const Text('拖我', style: TextStyle(color: Colors.white))),
              ),
              const SizedBox(width: 24),
              DragTarget<Color>(
                onAcceptWithDetails: (d) => setState(() => accepted = d.data),
                builder: (context, cand, rej) => Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  color: accepted ?? (cand.isNotEmpty ? Colors.teal.shade100 : Colors.grey.shade200),
                  child: Text(accepted == null ? '放到这里' : '已接收'),
                ),
              ),
            ],
          ),
        ),
        TopicSection(
          title: '平移元素',
          child: SizedBox(
            height: 140,
            child: Stack(
              children: [
                Positioned(
                  left: 80 + delta.dx,
                  top: 40 + delta.dy,
                  child: GestureDetector(
                    onPanUpdate: (e) => setState(() => delta += e.delta),
                    onPanEnd: (_) => setState(() => delta = Offset.zero),
                    child: const Chip(label: Text('拖动我'), avatar: Icon(Icons.open_with)),
                  ),
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
`;
  }

  if (t.includes('水波纹')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'InkWell / InkResponse 在 Material 祖先下绘制水波纹反馈。',
      children: [
        TopicSection(
          title: 'InkWell',
          child: Material(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
              child: const SizedBox(
                height: 80,
                width: double.infinity,
                child: Center(child: Text('点击查看水波纹')),
              ),
            ),
          ),
        ),
        TopicSection(
          title: 'ListTile（自带 ink）',
          child: Card(
            child: ListTile(
              leading: const Icon(Icons.waves),
              title: const Text('带水波纹的列表项'),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('滑动取消') || t.includes('Dismissible')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final items = List.generate(6, (i) => '条目 \${i + 1}');

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'Dismissible 实现滑动删除；需配合唯一 Key 与确认回调。',
      children: [
        TopicSection(
          title: '左滑删除',
          child: Column(
            children: [
              for (final item in List.of(items))
                Dismissible(
                  key: ValueKey(item),
                  background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 16), child: const Icon(Icons.delete, color: Colors.white)),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => setState(() => items.remove(item)),
                  child: ListTile(title: Text(item), subtitle: const Text('← 左滑')),
                ),
              if (items.isEmpty)
                TextButton(onPressed: () => setState(() => items.addAll(List.generate(6, (i) => '条目 \${i + 1}'))), child: const Text('重置列表')),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('输入框') || t.includes('表单') || t.includes('焦点') || t.includes('校验') || t.includes('读取') || t.includes('变动')) {
    const isForm = t.includes('表单') || t.includes('校验');
    const isFocus = t.includes('焦点') || t.includes('管理输入框');
    if (isForm) {
      return `import 'package:flutter/material.dart';
${kit}
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
      title: '${esc(t)}',
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
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('已保存: \$email')));
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
`;
    }
    if (isFocus) {
      return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final a = FocusNode();
  final b = FocusNode();

  @override
  void dispose() {
    a.dispose();
    b.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'FocusNode / FocusScope 在输入框间移动焦点；键盘「下一步」可 requestFocus。',
      children: [
        TopicSection(
          title: '焦点切换',
          child: Column(
            children: [
              TextField(
                focusNode: a,
                decoration: const InputDecoration(labelText: '字段 A', border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => FocusScope.of(context).requestFocus(b),
              ),
              const SizedBox(height: 12),
              TextField(
                focusNode: b,
                decoration: const InputDecoration(labelText: '字段 B', border: OutlineInputBorder()),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  OutlinedButton(onPressed: () => a.requestFocus(), child: const Text('聚焦 A')),
                  const SizedBox(width: 8),
                  OutlinedButton(onPressed: () => b.requestFocus(), child: const Text('聚焦 B')),
                  const SizedBox(width: 8),
                  OutlinedButton(onPressed: () => FocusScope.of(context).unfocus(), child: const Text('收起')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
    }
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final ctrl = TextEditingController();
  String live = '';

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() => setState(() => live = ctrl.text));
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'TextField / TextEditingController 读取与监听输入；InputDecoration 调整样式。',
      children: [
        TopicSection(
          title: '输入与实时读取',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: ctrl,
                decoration: const InputDecoration(
                  labelText: '昵称',
                  hintText: '输入点什么',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Text('实时: \$live'),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('读取: \${ctrl.text}'))),
                child: const Text('读取 controller.text'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('SnackBar')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'ScaffoldMessenger.showSnackBar 展示轻量反馈；可带 action。',
      children: [
        TopicSection(
          title: '展示 SnackBar',
          child: Wrap(
            spacing: 8,
            children: [
              FilledButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已保存'))),
                child: const Text('简单提示'),
              ),
              OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('已删除'),
                      action: SnackBarAction(label: '撤销', onPressed: () {}),
                    ),
                  );
                },
                child: const Text('带 Action'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('快捷') || t.includes('捷径') || t.includes('键盘焦点')) {
    return `import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int n = 0;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'Shortcuts + Actions + Intent 绑定键盘快捷键；Focus 管理可聚焦控件。',
      children: [
        TopicSection(
          title: 'Ctrl/Cmd + = 增加计数',
          child: Shortcuts(
            shortcuts: const {
              SingleActivator(LogicalKeyboardKey.equal, control: true): _IncIntent(),
              SingleActivator(LogicalKeyboardKey.equal, meta: true): _IncIntent(),
            },
            child: Actions(
              actions: {
                _IncIntent: CallbackAction<_IncIntent>(onInvoke: (_) {
                  setState(() => n++);
                  return null;
                }),
              },
              child: Focus(
                autofocus: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('计数: \$n', style: Theme.of(context).textTheme.headlineMedium),
                    const Text('先点本区域获取焦点，再按 Ctrl+=（macOS 用 Cmd+=）'),
                    const SizedBox(height: 8),
                    FilledButton(onPressed: () => setState(() => n++), child: const Text('或点按钮 +1')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _IncIntent extends Intent {
  const _IncIntent();
}

Widget buildDemo() => const DemoPage();
`;
  }

  return genInteraction({ ...m, title: '手势概览' });
}

function genAssets(m) {
  const t = m.title;
  if (t.includes('网络')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'Image.network 加载远程图；务必提供 loadingBuilder / errorBuilder。',
      children: [
        TopicSection(
          title: 'Image.network',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://docs.flutter.dev/assets/images/shared/brand/flutter/logo/flutter-opengraph.png',
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (c, child, p) {
                if (p == null) return child;
                return const SizedBox(height: 140, child: Center(child: CircularProgressIndicator()));
              },
              errorBuilder: (c, e, s) => Container(
                height: 140,
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: const Text('加载失败（检查网络）'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('占位') || t.includes('过渡')) {
    return `import 'dart:typed_data';
import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  static final _placeholder = MemoryImage(Uint8List.fromList(const [
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
    0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
    0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
    0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
    0x42, 0x60, 0x82,
  ]));

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'FadeInImage 先显示占位，再淡入目标图。',
      children: [
        TopicSection(
          title: 'FadeInImage.memoryNetwork 思路',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FadeInImage(
              placeholder: _placeholder,
              image: const NetworkImage(
                'https://docs.flutter.dev/assets/images/shared/brand/flutter/logo/flutter-opengraph.png',
              ),
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              imageErrorBuilder: (c, e, s) => Container(
                height: 140,
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Text('网络图加载失败'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('视频')) {
    return docPanel(
      t,
      '播放视频通常使用 video_player 插件；本示例合集不内嵌编解码依赖，要点如下。',
      ['添加 video_player 依赖', 'VideoPlayerController.networkUrl / asset', '初始化后用 VideoPlayer + 播放/暂停按钮', 'dispose 时释放 controller'],
      "final c = VideoPlayerController.networkUrl(Uri.parse(url));\\nawait c.initialize();\\nc.play();",
    );
  }

  if (t.includes('构建时转换') || t.includes('转换资源')) {
    return docPanel(
      t,
      '在构建流水线中压缩、生成分辨率或代码生成资源（如 flutter_gen）。',
      ['asset 变体与分辨率目录', 'CI 中压缩图片', '代码生成类型安全的 Asset 引用'],
      'flutter:\\n  assets:\\n    - assets/images/',
    );
  }

  // 添加资源 / 概览
  return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '在 pubspec.yaml 声明 assets，用 Image.asset / rootBundle 加载。',
      children: [
        TopicSection(
          title: 'Icon 作为内置资源示意',
          child: Row(
            children: [
              Icon(Icons.flutter_dash, size: 64, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 16),
              const Expanded(child: Text('本地图片请放 assets/ 并在 pubspec 声明后使用 Image.asset。')),
            ],
          ),
        ),
        const TopicSection(
          title: 'pubspec',
          child: TopicCode("flutter:\\n  assets:\\n    - assets/images/logo.png"),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
}

function genNav(m) {
  const t = m.title;
  if (t.includes('Deeplink') || t.includes('Universal') || t.includes('URL 策略') || t.includes('Android Deeplink') || t.includes('iOS')) {
    return docPanel(
      t,
      '深度链接与 URL 策略需原生工程配置，无法在此完全跑通，对应文档概述如下。',
      t.includes('Web')
        ? ['PathUrlStrategy / HashUrlStrategy', 'flutter_web_plugins 设置', '与路由器 path 对齐']
        : t.includes('Android')
          ? ['AndroidManifest intent-filter', 'app_links / go_router 解析', '验证 Digital Asset Links']
          : t.includes('iOS') || t.includes('Universal')
            ? ['Associated Domains', 'Info.plist', 'Universal Links 验证']
            : ['统一用路由器声明路径', '平台各自注册 scheme / applinks', '冷启动与热启动都要处理'],
      'go_router: redirect / deep linking docs',
    );
  }

  if (t.includes('Tab')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: TopicDemoScaffold(
        title: '${esc(t)}',
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
                        Center(child: Text('\$name 内容', style: const TextStyle(fontSize: 20))),
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
`;
  }

  if (t.includes('传递数据') || t.includes('返回数据')) {
    const returning = t.includes('返回');
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '${returning ? 'Navigator.pop(context, result) 把结果带回上一页。' : 'push 时通过构造函数或 RouteSettings.arguments 传参。'}',
      children: [
        TopicSection(
          title: '${returning ? '选择并返回' : '打开详情并传参'}',
          child: FilledButton(
            onPressed: () async {
              ${returning
                ? `final result = await Navigator.of(context).push<String>(
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: const Text('选择')),
                    body: ListView(
                      children: [
                        for (final s in ['苹果', '香蕉', '橙子'])
                          ListTile(
                            title: Text(s),
                            onTap: () => Navigator.pop(context, s),
                          ),
                      ],
                    ),
                  ),
                ),
              );
              if (context.mounted && result != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('返回: \$result')));
              }`
                : `await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: const Text('详情')),
                    body: const Center(child: Text('收到参数: 商品 #42', style: TextStyle(fontSize: 18))),
                  ),
                  settings: const RouteSettings(arguments: 42),
                ),
              );`}
            },
            child: Text('${returning ? '去选择' : '传入 ID=42'}'),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('抽屉') || t.includes('Drawer')) {
    return `import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${esc(t)}')),
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
          Text('${esc(t)}', style: Theme.of(context).textTheme.titleLarge),
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
`;
  }

  if (t.includes('Cupertino Sheet') || t.includes('Sheet')) {
    return `import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'iOS 风格可用 showCupertinoModalPopup / sheet；Material 侧常用 showModalBottomSheet。',
      children: [
        TopicSection(
          title: '底部 Sheet',
          child: Wrap(
            spacing: 8,
            children: [
              FilledButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => const SizedBox(
                      height: 180,
                      child: Center(child: Text('Material BottomSheet')),
                    ),
                  );
                },
                child: const Text('Material Sheet'),
              ),
              OutlinedButton(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (_) => CupertinoActionSheet(
                      title: const Text('操作'),
                      actions: [
                        CupertinoActionSheetAction(onPressed: () => Navigator.pop(context), child: const Text('确认')),
                      ],
                      cancelButton: CupertinoActionSheetAction(onPressed: () => Navigator.pop(context), child: const Text('取消')),
                    ),
                  );
                },
                child: const Text('Cupertino ActionSheet'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  // 导航至新页面 / 概览
  return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'Navigator.push / pop 做栈式导航；也可用 go_router 声明式路由。',
      children: [
        TopicSection(
          title: '打开新页面',
          child: FilledButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: const Text('第二页')),
                    body: Center(
                      child: FilledButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('返回'),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: const Text('Navigator.push'),
          ),
        ),
        const TopicSection(
          title: '概念',
          child: TopicCode('Navigator.push(context, MaterialPageRoute(...));\\nNavigator.pop(context);'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
}

function genAnim(m) {
  const t = m.title;
  if (t.includes('隐式') || t.includes('Container 的属性') || t.includes('过渡 Container')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool on = false;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'AnimatedContainer / AnimatedOpacity 等隐式动画：改属性即可过渡。',
      children: [
        TopicSection(
          title: 'AnimatedContainer',
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 450),
                curve: Curves.easeInOut,
                width: on ? 220 : 100,
                height: on ? 120 : 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: on ? Colors.deepOrange : Colors.teal,
                  borderRadius: BorderRadius.circular(on ? 28 : 8),
                  boxShadow: [
                    BoxShadow(blurRadius: on ? 16 : 4, color: Colors.black26, offset: const Offset(0, 4)),
                  ],
                ),
                child: Text(on ? 'ON' : 'OFF', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              FilledButton(onPressed: () => setState(() => on = !on), child: const Text('切换属性')),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('渐入') || t.includes('渐出')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'AnimatedOpacity 或 FadeTransition 做显隐渐变。',
      children: [
        TopicSection(
          title: 'AnimatedOpacity',
          child: Column(
            children: [
              AnimatedOpacity(
                opacity: visible ? 1 : 0,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  alignment: Alignment.center,
                  child: const Text('Hello Fade'),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(onPressed: () => setState(() => visible = !visible), child: Text(visible ? '渐出' : '渐入')),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('Hero')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '相同 tag 的 Hero 在路由切换时共享元素飞跃动画。',
      children: [
        TopicSection(
          title: '点击图片进入详情',
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: const Text('详情')),
                    body: Center(
                      child: Hero(
                        tag: 'hero-demo',
                        child: Icon(Icons.flutter_dash, size: 160, color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Hero(
              tag: 'hero-demo',
              child: Icon(Icons.flutter_dash, size: 72, color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('页面转场')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'PageRouteBuilder 自定义进入/退出过渡（滑动、淡入等）。',
      children: [
        TopicSection(
          title: '自定义转场',
          child: FilledButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (c, a, s) => Scaffold(
                    appBar: AppBar(title: const Text('新页')),
                    body: const Center(child: Text('从右侧滑入')),
                  ),
                  transitionsBuilder: (c, a, s, child) {
                    final offset = Tween(begin: const Offset(1, 0), end: Offset.zero).animate(a);
                    return SlideTransition(position: offset, child: child);
                  },
                ),
              );
            },
            child: const Text('滑动打开'),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('物理') || t.includes('模拟')) {
    return `import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> with SingleTickerProviderStateMixin {
  late final AnimationController c =
      AnimationController.unbounded(vsync: this)..addListener(() => setState(() {}));

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  void fling() {
    c.animateWith(
      SpringSimulation(
        const SpringDescription(mass: 1, stiffness: 100, damping: 10),
        c.value,
        120,
        -2000,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final x = c.value.clamp(0, 200).toDouble();
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'SpringSimulation 等物理仿真驱动 AnimationController。',
      children: [
        TopicSection(
          title: '弹簧',
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Stack(
                  children: [
                    Positioned(
                      left: x,
                      child: const CircleAvatar(radius: 24, child: Icon(Icons.sports_baseball)),
                    ),
                  ],
                ),
              ),
              FilledButton(onPressed: fling, child: const Text('弹一下')),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('交错') || t.includes('菜单')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> with SingleTickerProviderStateMixin {
  late final AnimationController c = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '用 Interval 把一条时间轴切成多段，实现交错出现。',
      children: [
        TopicSection(
          title: '交错列表',
          child: Column(
            children: [
              for (var i = 0; i < 4; i++)
                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: c,
                    curve: Interval(i * 0.2, 0.2 + i * 0.2 + 0.4, curve: Curves.easeOut),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('\${i + 1}')),
                    title: Text('菜单项 \${i + 1}'),
                  ),
                ),
              Row(
                children: [
                  FilledButton(onPressed: () => c.forward(from: 0), child: const Text('播放')),
                  const SizedBox(width: 8),
                  OutlinedButton(onPressed: () => c.reverse(), child: const Text('反向')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('API')) {
    return docPanel(
      t,
      '动画核心 API：Animation、AnimationController、Tween、Curve、Listener/Status。',
      ['AnimationController 驱动 0..1', 'Tween.animate(controller)', 'CurvedAnimation 套曲线', 'AnimatedWidget / AnimatedBuilder 重建'],
      'controller = AnimationController(vsync: this, duration: …);',
    );
  }

  // 教程 / 概览
  return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> with SingleTickerProviderStateMixin {
  late final AnimationController c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat(reverse: true);
  late final Animation<double> scale = Tween(begin: 0.8, end: 1.2).animate(CurvedAnimation(parent: c, curve: Curves.easeInOut));

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '显式动画：Controller + Tween；隐式动画：Animated* widget。',
      children: [
        TopicSection(
          title: 'ScaleTransition',
          child: Center(
            child: ScaleTransition(
              scale: scale,
              child: const FlutterLogo(size: 96),
            ),
          ),
        ),
        const TopicSection(
          title: '对照',
          child: TopicCode('隐式: AnimatedContainer\\n显式: AnimationController + Tween\\n共享元素: Hero'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
}

function genI18n(m) {
  return `import 'package:flutter/material.dart';
${kit}
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
      title: '${esc(m.title)}',
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
          child: TopicCode('flutter gen-l10n\\nMaterialApp(localizationsDelegates: …, supportedLocales: …)'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
}

function genData(m) {
  const t = m.title;
  if (t.includes('网络') || t.includes('获取') || t.includes('发送') || t.includes('更新') || t.includes('删除') || t.includes('认证') || t.includes('WebSocket')) {
    if (t.includes('WebSocket')) {
      return docPanel(t, 'WebSocket 长连接适合实时消息；示例侧用假会话展示状态机。', ['连接 / 监听 / 发送 / 关闭', '断线重连策略', '与 UI 的 StreamBuilder 结合'], 'channel = WebSocketChannel.connect(uri);');
    }
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool loading = false;
  String? result;
  String? error;

  Future<void> mockFetch() async {
    setState(() { loading = true; error = null; result = null; });
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() {
      loading = false;
      result = '{\\n  "id": 1,\\n  "title": "mock todo"\\n}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'http / dio 发请求；用 FutureBuilder 或自行管理 loading/error/data。此处为本地模拟。',
      children: [
        TopicSection(
          title: '模拟请求',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(onPressed: loading ? null : mockFetch, child: Text(loading ? '请求中…' : '发起 GET（模拟）')),
              const SizedBox(height: 12),
              if (loading) const Center(child: CircularProgressIndicator()),
              if (result != null) TopicCode(result!),
              if (error != null) Text(error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
          ),
        ),
        const TopicSection(
          title: '真实代码形态',
          child: TopicCode("final res = await http.get(Uri.parse(url));\\nif (res.statusCode == 200) …"),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('JSON')) {
    return `import 'dart:convert';
import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String out = '';

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'dart:convert 的 jsonEncode / jsonDecode；大 JSON 可放到 isolate。',
      children: [
        TopicSection(
          title: '编解码',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                onPressed: () {
                  final map = {'name': 'Flutter', 'stars': 5};
                  final s = jsonEncode(map);
                  final back = jsonDecode(s) as Map<String, dynamic>;
                  setState(() => out = 'encode: \$s\\ndecode name=\${back['name']}');
                },
                child: const Text('jsonEncode / Decode'),
              ),
              const SizedBox(height: 8),
              if (out.isNotEmpty) TopicCode(out),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('键值') || t.includes('文件') || t.includes('SQLite')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final store = <String, String>{};
  final keyCtrl = TextEditingController(text: 'theme');
  final valCtrl = TextEditingController(text: 'dark');

  @override
  void dispose() {
    keyCtrl.dispose();
    valCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: 'shared_preferences / path_provider+File / sqflite 分别适合 KV、文件、关系数据。此处用内存 Map 模拟 KV。',
      children: [
        TopicSection(
          title: '模拟持久化',
          child: Column(
            children: [
              TextField(controller: keyCtrl, decoration: const InputDecoration(labelText: 'key', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              TextField(controller: valCtrl, decoration: const InputDecoration(labelText: 'value', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              Row(
                children: [
                  FilledButton(onPressed: () => setState(() => store[keyCtrl.text] = valCtrl.text), child: const Text('写入')),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {
                      valCtrl.text = store[keyCtrl.text] ?? '';
                      setState(() {});
                    },
                    child: const Text('读取'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TopicCode(store.entries.map((e) => '\${e.key}=\${e.value}').join('\\n').isEmpty ? '(空)' : store.entries.map((e) => '\${e.key}=\${e.value}').join('\\n')),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  // 状态管理系列
  return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int local = 0;
  final vn = ValueNotifier<int>(0);

  @override
  void dispose() {
    vn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '短暂状态留在 Widget；共享/持久状态上提或用专用方案（Provider、Riverpod 等）。',
      children: [
        TopicSection(
          title: 'setState（短暂状态）',
          child: Row(
            children: [
              Text('\$local', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(width: 16),
              FilledButton(onPressed: () => setState(() => local++), child: const Text('+1')),
            ],
          ),
        ),
        TopicSection(
          title: 'ValueListenableBuilder',
          child: ValueListenableBuilder<int>(
            valueListenable: vn,
            builder: (_, v, __) => Row(
              children: [
                Text('\$v', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(width: 16),
                FilledButton(onPressed: () => vn.value++, child: const Text('notifier +1')),
              ],
            ),
          ),
        ),
        const TopicSection(
          title: '文档对应',
          child: TopicBulletList([
            '声明式：UI = f(state)',
            '短暂 vs 应用状态',
            '简单场景 setState 足够；复杂再引入方案',
          ]),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
}

function genPerf(m) {
  const t = m.title;
  if (t.includes('延迟') || t.includes('组件')) {
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool showHeavy = false;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '延迟构建昂贵子树（或 deferred 加载库）可缩短首帧。',
      children: [
        TopicSection(
          title: '按需构建',
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('构建「重」列表'),
                value: showHeavy,
                onChanged: (v) => setState(() => showHeavy = v),
              ),
              if (showHeavy)
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: 200,
                    itemBuilder: (_, i) => ListTile(title: Text('row \$i')),
                  ),
                )
              else
                const Text('未构建列表 → 首屏更轻'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (t.includes('应用大小') || t.includes('Impeller') || t.includes('分析') || t.includes('并发')) {
    return docPanel(
      t,
      t.includes('Impeller')
        ? 'Impeller 是新一代渲染后端，减少运行时着色器编译卡顿。'
        : t.includes('大小')
          ? '减小安装包：拆分 ABI、延迟组件、压缩资源、移除未用代码。'
          : t.includes('并发')
            ? 'CPU 密集工作放到 isolate / compute，避免阻塞 UI isolate。'
            : '用 DevTools Performance / Timeline 定位 jank。',
      t.includes('Impeller')
        ? ['Android/iOS 默认逐步启用', '关注兼容与回退 Skia 的场景']
        : t.includes('大小')
          ? ['--split-per-abi', '树摇与混淆', '检查 assets 体积']
          : t.includes('并发')
            ? ['compute()', 'Isolate.run', '不要在 UI 线程做重 JSON']
            : ['打开 Performance overlay', '减少 rebuild 范围', 'ListView.builder'],
      t.includes('并发') ? 'await Isolate.run(() => heavy());' : 'flutter run --profile',
    );
  }

  // 渲染性能 / 最佳实践 / 概览
  return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool builderMode = true;
  int rebuilds = 0;

  @override
  Widget build(BuildContext context) {
    rebuilds++;
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '长列表用 builder；缩小 setState 范围；避免不必要的重绘。',
      children: [
        TopicSection(
          title: 'ListView 对比',
          child: Column(
            children: [
              SwitchListTile(
                title: Text(builderMode ? 'ListView.builder' : 'ListView(children: …)'),
                value: builderMode,
                onChanged: (v) => setState(() => builderMode = v),
              ),
              SizedBox(
                height: 180,
                child: builderMode
                    ? ListView.builder(
                        itemCount: 1000,
                        itemBuilder: (_, i) => ListTile(dense: true, title: Text('lazy \$i')),
                      )
                    : ListView(
                        children: [for (var i = 0; i < 80; i++) ListTile(dense: true, title: Text('eager \$i'))],
                      ),
              ),
              Text('本页 build 次数（示意）: \$rebuilds', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
}

function genPackages(m) {
  return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(m.title)}',
      summary: 'pub.dev 上的 package/plugin 扩展能力；应用依赖写在 pubspec，插件含原生代码。',
      children: [
        TopicSection(
          title: '本示例已用依赖（节选）',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              Chip(label: Text('go_router')),
              Chip(label: Text('flutter_markdown')),
              Chip(label: Text('cupertino_icons')),
            ],
          ),
        ),
        const TopicSection(
          title: '常用命令',
          child: TopicCode('flutter pub add http\\nflutter pub get\\nflutter pub outdated'),
        ),
        TopicSection(
          title: '要点',
          child: TopicBulletList([
            '${esc(
              m.title.includes('作者') || m.title.includes('开发')
                ? '插件需 Android/iOS/… 平台实现与 Federated 结构'
                : '先查 Flutter Favorites 与点赞量、维护状态',
            )}',
            '注意 Dart 3 / Flutter SDK 约束',
            '权限与隐私说明写进 README',
          ]),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
}

function genDocHeavy(m) {
  const t = m.title;
  const mod = m.module;
  let summary = '本主题以工程配置与流程为主，示例区对齐文档概述；完整步骤见「官方文档」Tab。';
  let points = ['阅读对应官方文档章节', '在真实工程中按平台操作', '本合集聚焦可运行 UI 概念'];
  let code = '';

  if (mod.includes('架构') || t.includes('架构') || t.includes('依赖注入') || t.includes('设计模式') || t.includes('UI 层') || t.includes('数据层')) {
    summary = '应用架构关注分层、状态流向与可测试性；用示意图对照文档。';
    return `import 'package:flutter/material.dart';
${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    Widget layer(String name, Color c) => Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(10)),
      child: Text(name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
    return TopicDemoScaffold(
      title: '${esc(t)}',
      summary: '${esc(summary)}',
      children: [
        TopicSection(
          title: '分层示意',
          child: Column(
            children: [
              layer('UI 层（Widgets / ViewModel）', cs.primaryContainer),
              const Icon(Icons.arrow_downward),
              layer('领域 / 用例', cs.secondaryContainer),
              const Icon(Icons.arrow_downward),
              layer('数据层（Repository / API / DB）', cs.tertiaryContainer),
            ],
          ),
        ),
        const TopicSection(
          title: '文档要点',
          child: TopicBulletList([
            '单向数据流，UI 只反映状态',
            '依赖注入便于测试替换',
            '按功能分模块，避免巨型文件',
          ]),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }

  if (mod.includes('测试') || t.includes('测试') || t.includes('调试') || t.includes('错误') || t.includes('模拟')) {
    summary = '测试金字塔：单元 → Widget → 集成；调试用 DevTools 与断言。';
    points = t.includes('Widget')
      ? ['testWidgets + WidgetTester', 'find.text / find.byType / find.byKey', 'pump / pumpAndSettle']
      : t.includes('集成')
        ? ['integration_test 包', '真机/模拟器跑通关键路径', '可接 CI']
        : t.includes('单元') || t.includes('模拟')
          ? ['test() 纯 Dart', 'mocktail / mockito 替身', '不依赖 UI 绑定']
          : t.includes('调试') || t.includes('错误')
            ? ['Flutter DevTools', '断点与 logging', 'FlutterError.onError / PlatformDispatcher']
            : ['先写能失败的测试', '再实现到绿', '保持测试快而稳'];
    code = t.includes('Widget')
      ? "await tester.pumpWidget(MaterialApp(home: MyWidget()));\\nexpect(find.text('Hi'), findsOneWidget);"
      : 'flutter test\\nflutter drive --driver=…';
    return docPanel(t, summary, points, code);
  }

  if (mod.includes('平台') || mod.includes('集成') || t.includes('Android') || t.includes('iOS') || t.includes('Web') || t.includes('Windows') || t.includes('桌面') || t.includes('闪屏') || t.includes('启动') || t.includes('插件') || t.includes('原生') || t.includes('预测')) {
    return docPanel(
      t,
      '平台集成与工程设定需在 android/ios/web 目录配置，示例 App 内仅列出概述要点。',
      points = [
        '使用 flutter create 生成的平台文件夹',
        '权限、签名、图标与启动页在原生侧配置',
        '插件通过 MethodChannel / FFI 与宿主通信',
      ],
      'flutter create --platforms=android,ios,web,windows .',
    );
  }

  if (mod.includes('打包') || mod.includes('部署') || t.includes('发布') || t.includes('flavor') || t.includes('混淆') || t.includes('持续')) {
    return docPanel(
      t,
      '打包发布在本地/CI 执行构建命令与商店提交流程。',
      t.includes('混淆')
        ? ['--obfuscate --split-debug-info', '妥善保存符号表', '注意反射/序列化库']
        : t.includes('flavor')
          ? ['productFlavors 与 dart-define', '多环境 API 地址', '图标与应用名区分']
          : ['flutter build apk/appbundle/ipa/web', '签名与证书', '商店元数据与隐私表单'],
      'flutter build appbundle --release',
    );
  }

  if (mod.includes('现有应用') || t.includes('Flutter module') || t.includes('Fragment') || t.includes('内嵌') || t.includes('多个 Flutter')) {
    return docPanel(
      t,
      'Add-to-app：把 Flutter 模块嵌入既有 Android/iOS 工程。',
      ['flutter create -t module', '原生侧挂载 FlutterActivity / FlutterViewController', '注意引擎复用与多实例成本'],
      'flutter create -t module my_flutter_module',
    );
  }

  if (t.includes('Firebase') || t.includes('Google APIs')) {
    return docPanel(
      t,
      '通过官方插件接入 Firebase / Google API，需控制台配置与平台密钥。',
      ['创建 Firebase 项目并登记应用', 'FlutterFire CLI 配置', '按产品引入对应插件'],
      'dart pub global activate flutterfire_cli\\nflutterfire configure',
    );
  }

  return docPanel(t, summary, points, code || undefined);
}

function generate(m) {
  const n = m.n;
  const folder = m.moduleFolder || '';
  const section = m.sectionFolder || '';

  if (n === 0) return gen0();
  if (n >= 30 && n <= 39) return genAdaptive(m);
  if (n >= 40 && n <= 47) return genTheme(m);
  if (n >= 48 && n <= 63) return genInteraction(m);
  if (n >= 64 && n <= 69) return genAssets(m);
  if (n >= 70 && n <= 81) return genNav(m);
  if (n >= 82 && n <= 93) return genAnim(m);
  if (n === 100) return genI18n(m);
  if (n >= 101 && n <= 118) return genData(m);
  if (n >= 148 && n <= 153) return genPackages(m);
  if (n >= 168 && n <= 176) return genPerf(m);
  // architecture, platform, test, deploy, add-to-app, firebase…
  if (n >= 119 && n <= 147) return genDocHeavy(m);
  if (n >= 154 && n <= 167) return genDocHeavy(m);
  if (n >= 177 && n <= 192) return genDocHeavy(m);
  return genDocHeavy(m);
}

let count = 0;
for (const m of META) {
  if (skip(m.n)) continue;
  const content = generate(m);
  writeDemo(m.n, content);
  try {
    syncExample(m, content);
  } catch (_) {}
  count++;
}
console.log('regenerated', count, 'demos');
