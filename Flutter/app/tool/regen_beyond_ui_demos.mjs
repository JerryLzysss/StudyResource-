/**
 * 「界面以外的开发」demo_101..192：按主题概述生成可交互/可视化效果。
 * node tool/regen_beyond_ui_demos.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.join(__dirname, '..');
const OUT = path.join(ROOT, 'lib', 'examples');
const DOCS = path.join(ROOT, '..', 'FlutterDocs');
const kit = `import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';\n`;

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

function esc(s) {
  return String(s).replace(/\\/g, '\\\\').replace(/'/g, "\\'");
}

function writeDemo(n, content) {
  fs.writeFileSync(path.join(OUT, `demo_${n}.dart`), content, 'utf8');
}

function syncExample(m, content) {
  const base = path.join(DOCS, m.sectionFolder, m.moduleFolder);
  if (!fs.existsSync(base)) return;
  function walk(dir) {
    let hits = [];
    for (const ent of fs.readdirSync(dir, { withFileTypes: true })) {
      const p = path.join(dir, ent.name);
      if (ent.isDirectory()) hits = hits.concat(walk(p));
      else if (ent.name === 'README.md') {
        const head = fs.readFileSync(p, 'utf8').slice(0, 240);
        if (head.includes(`# ${m.title}`) || head.includes(m.title)) {
          hits.push(path.join(dir, 'example.dart'));
        }
      }
    }
    return hits;
  }
  const targets = walk(base);
  for (const t of targets) fs.writeFileSync(t, content, 'utf8');
  if (m.title === m.module || targets.length === 0) {
    if (fs.existsSync(path.join(base, 'README.md'))) {
      fs.writeFileSync(path.join(base, 'example.dart'), content, 'utf8');
    }
  }
}

const META = loadMeta().filter((m) => m.sectionFolder === '界面以外的开发');

// ——— helpers ———
function scaffold(title, summary, body, { stateful = false, extraImports = '', stateFields = '', methods = '' } = {}) {
  if (!stateful) {
    return `import 'package:flutter/material.dart';
${extraImports}${kit}
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(title)}',
      summary: '${esc(summary)}',
      children: [
${body}
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
  }
  return `import 'package:flutter/material.dart';
${extraImports}${kit}
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
${stateFields}
${methods}
  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '${esc(title)}',
      summary: '${esc(summary)}',
      children: [
${body}
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
`;
}

// ===================== 01 数据调用 & 后端 =====================

function genData(m) {
  const t = m.title;
  const n = m.n;

  if (n === 101 || t === '数据调用 & 后端') {
    return scaffold(
      t,
      '涵盖状态管理、网络、序列化、本地持久化，以及 Firebase / Google API 等后端能力。',
      `        TopicSection(
          title: '本模块地图',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final e in [
                ('状态管理', Icons.account_tree),
                ('网络请求', Icons.cloud),
                ('JSON', Icons.data_object),
                ('本地存储', Icons.storage),
                ('Firebase', Icons.local_fire_department),
              ])
                Chip(avatar: Icon(e.\$2, size: 16), label: Text(e.\$1)),
            ],
          ),
        ),
        const TopicSection(
          title: '实践顺序',
          child: TopicBulletList([
            '先理清短暂状态 vs 应用状态',
            '再用 Future / Stream 对接网络',
            '需要离线时再引入 KV / 文件 / SQLite',
          ]),
        ),`,
    );
  }

  if (t.includes('声明式')) {
    return scaffold(
      t,
      '声明式：UI = f(state)。改状态，框架重建对应 Widget，而不是命令式改控件。',
      `        TopicSection(
          title: '拖动即重建',
          child: Column(
            children: [
              Text('温度 \${temp.toStringAsFixed(0)}°C', style: Theme.of(context).textTheme.headlineSmall),
              Slider(value: temp, min: -10, max: 40, onChanged: (v) => setState(() => temp = v)),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 72,
                width: double.infinity,
                alignment: Alignment.center,
                color: Color.lerp(Colors.blue, Colors.orange, (temp + 10) / 50)!,
                child: Text(temp < 15 ? '偏冷' : temp < 28 ? '舒适' : '偏热',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              const Text('没有 findViewById / setText——只更新 temp，UI 自动反映。'),
            ],
          ),
        ),`,
      { stateful: true, stateFields: '  double temp = 22;\n' },
    );
  }

  if (t.includes('短暂') || t.includes('持久状态')) {
    return scaffold(
      t,
      '短暂状态：仅当前 Widget 关心（动画、勾选）。应用/持久状态：跨页面或需落盘。',
      `        TopicSection(
          title: '短暂：本页 Checkbox',
          child: CheckboxListTile(
            title: const Text('仅本页记得'),
            value: ephemeral,
            onChanged: (v) => setState(() => ephemeral = v ?? false),
          ),
        ),
        TopicSection(
          title: '应用状态：提升到父级计数',
          child: Row(
            children: [
              Text('共享计数 \$appCount', style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              FilledButton(onPressed: () => setState(() => appCount++), child: const Text('全局 +1')),
            ],
          ),
        ),
        const TopicSection(
          title: '持久化',
          child: Text('跨启动保存需 shared_preferences / 数据库等（见本模块持久化章节）。'),
        ),`,
      { stateful: true, stateFields: '  bool ephemeral = false;\n  int appCount = 0;\n' },
    );
  }

  if (t.includes('简单的状态') || t.includes('状态管理概览') || t.includes('状态管理参考')) {
    const isRef = t.includes('参考');
    return scaffold(
      t,
      isRef
        ? '常见方案：setState、InheritedWidget、Provider、Riverpod、Bloc…按复杂度选型。'
        : '简单场景：状态放在共同祖先，用构造函数或回调下发；不必一上来引入框架。',
      isRef
        ? `        TopicSection(
          title: '方案对照（概念）',
          child: Column(
            children: [
              for (final row in [
                ('setState', '单页 / 局部'),
                ('InheritedWidget', '轻量下发'),
                ('Provider / Riverpod', '依赖注入 + 监听'),
                ('Bloc / Cubit', '事件驱动'),
              ])
                ListTile(
                  dense: true,
                  title: Text(row.\$1),
                  subtitle: Text(row.\$2),
                  trailing: Icon(Icons.check_circle_outline, color: Theme.of(context).colorScheme.primary),
                ),
            ],
          ),
        ),`
        : `        TopicSection(
          title: '父持有、子展示',
          child: Column(
            children: [
              Text('\$count', style: Theme.of(context).textTheme.displaySmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CounterBtn(label: '-', onTap: () => setState(() => count--)),
                  const SizedBox(width: 12),
                  _CounterBtn(label: '+', onTap: () => setState(() => count++)),
                ],
              ),
            ],
          ),
        ),
        TopicSection(
          title: 'ValueNotifier',
          child: ValueListenableBuilder<int>(
            valueListenable: vn,
            builder: (_, v, __) => ListTile(
              title: Text('notifier = \$v'),
              trailing: IconButton(icon: const Icon(Icons.add), onPressed: () => vn.value++),
            ),
          ),
        ),`,
      {
        stateful: true,
        stateFields: isRef ? '' : '  int count = 0;\n  final vn = ValueNotifier<int>(0);\n',
        methods: isRef
          ? ''
          : `  @override\n  void dispose() {\n    vn.dispose();\n    super.dispose();\n  }\n`,
        extraImports: isRef
          ? ''
          : '',
      },
    ).replace(
      'Widget buildDemo() => const DemoPage();',
      isRef
        ? 'Widget buildDemo() => const DemoPage();'
        : `class _CounterBtn extends StatelessWidget {
  const _CounterBtn({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) =>
      FilledButton(onPressed: onTap, child: Text(label));
}

Widget buildDemo() => const DemoPage();`,
    );
  }

  if (t.includes('WebSocket')) {
    return scaffold(
      t,
      'WebSocket 保持长连接，适合聊天、行情等推送。下方模拟连接状态与收发。',
      `        TopicSection(
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
        ),`,
      { stateful: true, stateFields: '  bool connected = false;\n  final logs = <String>[];\n' },
    );
  }

  if (t.includes('JSON') || t.includes('序列化')) {
    const bg = t.includes('后台');
    return scaffold(
      t,
      bg
        ? '大 JSON 用 compute / Isolate.run 解析，避免卡住 UI isolate。'
        : 'jsonEncode / jsonDecode（或 json_serializable）在 Dart 对象与 JSON 间转换。',
      bg
        ? `        TopicSection(
          title: '模拟后台解析',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                onPressed: busy
                    ? null
                    : () async {
                        setState(() { busy = true; out = '解析中…'; });
                        await Future<void>.delayed(const Duration(milliseconds: 800));
                        if (!mounted) return;
                        setState(() {
                          busy = false;
                          out = 'Isolate 完成：解析 5000 条记录（模拟）';
                        });
                      },
                child: Text(busy ? '后台运行中…' : 'compute(() => decodeHugeJson)'),
              ),
              const SizedBox(height: 8),
              if (busy) const LinearProgressIndicator(),
              Text(out),
            ],
          ),
        ),`
        : `        TopicSection(
          title: '编解码演示',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                onPressed: () {
                  final map = {'id': 1, 'name': 'Flutter'};
                  final s = jsonEncode(map);
                  final back = jsonDecode(s) as Map<String, dynamic>;
                  setState(() => out = 'encode → \$s\\ndecode name=\${back['name']}');
                },
                child: const Text('jsonEncode / jsonDecode'),
              ),
              const SizedBox(height: 8),
              if (out.isNotEmpty) TopicCode(out),
            ],
          ),
        ),`,
      {
        stateful: true,
        extraImports: bg ? '' : "import 'dart:convert';\n",
        stateFields: bg ? "  bool busy = false;\n  String out = '';\n" : "  String out = '';\n",
      },
    );
  }

  if (t.includes('键值') || t.includes('硬盘')) {
    return scaffold(
      t,
      'shared_preferences 等把简单键值写入本地。此处用内存 Map 模拟读写。',
      `        TopicSection(
          title: 'KV 读写',
          child: Column(
            children: [
              TextField(controller: k, decoration: const InputDecoration(labelText: 'key', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              TextField(controller: v, decoration: const InputDecoration(labelText: 'value', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              Row(children: [
                FilledButton(onPressed: () => setState(() => store[k.text] = v.text), child: const Text('set')),
                const SizedBox(width: 8),
                OutlinedButton(onPressed: () { v.text = store[k.text] ?? ''; setState(() {}); }, child: const Text('get')),
                const SizedBox(width: 8),
                TextButton(onPressed: () => setState(() => store.remove(k.text)), child: const Text('remove')),
              ]),
              const SizedBox(height: 8),
              TopicCode(store.isEmpty ? '(empty)' : store.entries.map((e) => '\${e.key}=\${e.value}').join('\\n')),
            ],
          ),
        ),`,
      {
        stateful: true,
        stateFields:
          "  final store = <String, String>{};\n  final k = TextEditingController(text: 'theme');\n  final v = TextEditingController(text: 'dark');\n",
        methods: `  @override\n  void dispose() {\n    k.dispose();\n    v.dispose();\n    super.dispose();\n  }\n`,
      },
    );
  }

  if (t.includes('读写文件') || t.includes('文件')) {
    return scaffold(
      t,
      'path_provider 取目录 + File 读写。下方模拟一个内存「文件」。',
      `        TopicSection(
          title: '模拟文件内容',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: ctrl,
                maxLines: 4,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'notes.txt'),
              ),
              const SizedBox(height: 8),
              Row(children: [
                FilledButton(onPressed: () => setState(() => disk = ctrl.text), child: const Text('写入')),
                const SizedBox(width: 8),
                OutlinedButton(onPressed: () { ctrl.text = disk; setState(() {}); }, child: const Text('读取')),
              ]),
              Text('磁盘快照长度: \${disk.length} 字符', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),`,
      {
        stateful: true,
        stateFields: "  String disk = '';\n  final ctrl = TextEditingController();\n",
        methods: `  @override\n  void dispose() {\n    ctrl.dispose();\n    super.dispose();\n  }\n`,
      },
    );
  }

  if (t.includes('SQLite')) {
    return scaffold(
      t,
      'sqflite 在设备上跑 SQLite。此处用 List 模拟表的增删查。',
      `        TopicSection(
          title: 'todos 表（内存）',
          child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    decoration: const InputDecoration(hintText: '新任务', border: OutlineInputBorder()),
                    onSubmitted: (_) => _add(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(onPressed: _add, child: const Text('INSERT')),
              ]),
              const SizedBox(height: 8),
              for (var i = 0; i < rows.length; i++)
                ListTile(
                  leading: Text('#\${i + 1}'),
                  title: Text(rows[i]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => setState(() => rows.removeAt(i)),
                  ),
                ),
              if (rows.isEmpty) const Text('SELECT * → 空表'),
            ],
          ),
        ),`,
      {
        stateful: true,
        stateFields: "  final rows = <String>['学习 Flutter', '写示例'];\n  final ctrl = TextEditingController();\n",
        methods: `  void _add() {\n    final t = ctrl.text.trim();\n    if (t.isEmpty) return;\n    setState(() {\n      rows.add(t);\n      ctrl.clear();\n    });\n  }\n\n  @override\n  void dispose() {\n    ctrl.dispose();\n    super.dispose();\n  }\n`,
      },
    );
  }

  if (t.includes('Firebase') || t.includes('Google APIs')) {
    const fb = t.includes('Firebase');
    return scaffold(
      t,
      fb
        ? 'FlutterFire 接入 Analytics、Auth、Firestore、Crashlytics 等；需控制台配置。'
        : '通过 googleapis / 官方插件调用 Maps、Sign-In 等，需 OAuth 与平台密钥。',
      `        TopicSection(
          title: '${fb ? '常见 Firebase 产品' : '常见 Google 能力'}',
          child: Column(
            children: [
              for (final p in ${fb ? "['Authentication', 'Cloud Firestore', 'Cloud Messaging', 'Crashlytics', 'Remote Config']" : "['Google Sign-In', 'Maps', 'Drive API', 'Calendar API']"})
                CheckboxListTile(
                  dense: true,
                  title: Text(p),
                  value: selected.contains(p),
                  onChanged: (v) => setState(() {
                    if (v == true) {
                      selected.add(p);
                    } else {
                      selected.remove(p);
                    }
                  }),
                ),
              Text('已选 \${selected.length} 项（示意接入清单）'),
            ],
          ),
        ),
        TopicSection(
          title: '配置命令',
          child: TopicCode("${fb
              ? 'dart pub global activate flutterfire_cli\\\\nflutterfire configure'
              : '在 Google Cloud 创建凭据\\\\n按插件 README 配置 Android/iOS'}"),
        ),`,
      {
        stateful: true,
        stateFields: '  final selected = <String>{};\n',
      },
    );
  }

  // 网络系列
  if (t.includes('网络') || t.includes('获取') || t.includes('认证') || t.includes('发送') || t.includes('更新') || t.includes('删除')) {
    let verb = 'GET';
    let summary = '用 http/dio 发请求，处理状态码与 JSON。';
    if (t.includes('认证')) {
      verb = 'GET + Authorization';
      summary = '在 Header 中带 Token / API Key；注意勿把密钥写进客户端仓库。';
    } else if (t.includes('发送')) {
      verb = 'POST';
      summary = 'POST body（JSON/form）创建资源；检查 201/400。';
    } else if (t.includes('更新')) {
      verb = 'PUT/PATCH';
      summary = '更新已有资源；幂等语义按 API 约定。';
    } else if (t.includes('删除')) {
      verb = 'DELETE';
      summary = '删除资源；成功后更新本地列表状态。';
    } else if (t.includes('概览')) {
      verb = 'REST';
      summary = 'REST：GET/POST/PUT/PATCH/DELETE；也可用 GraphQL 等。';
    }

    const showBody = verb.includes('POST') || verb.includes('PUT') || verb.includes('PATCH');
    const showAuth = verb.includes('Authorization');

    return scaffold(
      t,
      summary,
      `        TopicSection(
          title: '模拟 ${esc(verb)}',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ${showBody ? `TextField(
                controller: bodyCtrl,
                decoration: const InputDecoration(labelText: 'JSON body', border: OutlineInputBorder()),
                maxLines: 2,
              ),` : ''}
              ${showAuth ? `TextField(
                controller: tokenCtrl,
                decoration: const InputDecoration(labelText: 'Bearer token', border: OutlineInputBorder()),
              ),` : ''}
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
                child: Text(loading ? '请求中…' : '执行 ${esc(verb)}（模拟）'),
              ),
              const SizedBox(height: 12),
              if (loading) const Center(child: CircularProgressIndicator()),
              if (result != null) TopicCode(result!),
            ],
          ),
        ),`,
      {
        stateful: true,
        stateFields: `  bool loading = false;\n  String? result;\n  final bodyCtrl = TextEditingController(text: '{"title":"hi"}');\n  final tokenCtrl = TextEditingController(text: 'eyJhbGciOi...');\n`,
        methods: `  String _fakeResponse() {
${
  verb.includes('DELETE')
    ? "    return '204 No Content';"
    : verb.includes('POST') && !verb.includes('PUT')
      ? "    return '201 Created\\n\${bodyCtrl.text}';"
      : verb.includes('PUT') || verb.includes('PATCH')
        ? "    return '200 OK\\nupdated: \${bodyCtrl.text}';"
        : showAuth
          ? "    return '200 OK\\nAuthorization: Bearer \${tokenCtrl.text.substring(0, 12)}…\\n{\"user\":\"demo\"}';"
          : '    return \'200 OK\\n{"id":1,"title":"mock"}\';'
}
  }

  @override
  void dispose() {
    bodyCtrl.dispose();
    tokenCtrl.dispose();
    super.dispose();
  }
`,
      },
    );
  }

  // fallback state
  return scaffold(
    t,
    '数据层把 UI 与网络/存储隔开；用清晰的状态（loading/data/error）驱动界面。',
    `        TopicSection(
          title: '状态机示意',
          child: Column(
            children: [
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'idle', label: Text('idle')),
                  ButtonSegment(value: 'loading', label: Text('loading')),
                  ButtonSegment(value: 'data', label: Text('data')),
                  ButtonSegment(value: 'error', label: Text('error')),
                ],
                selected: {phase},
                onSelectionChanged: (s) => setState(() => phase = s.first),
              ),
              const SizedBox(height: 16),
              if (phase == 'loading') const CircularProgressIndicator(),
              if (phase == 'data') const Text('✓ 展示列表/详情'),
              if (phase == 'error') Text('出错了，点重试', style: TextStyle(color: Theme.of(context).colorScheme.error)),
              if (phase == 'idle') const Text('等待用户操作'),
            ],
          ),
        ),`,
    { stateful: true, stateFields: "  String phase = 'idle';\n" },
  );
}

// ===================== 02 应用架构 =====================

function genArch(m) {
  const t = m.title;

  if (t.includes('依赖注入')) {
    return scaffold(
      t,
      '依赖注入：上层不 new 具体实现，便于测试时替换 Fake。',
      `        TopicSection(
          title: '切换 Repository 实现',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SwitchListTile(
                title: Text(useFake ? 'FakeRepo（测试）' : 'ApiRepo（生产）'),
                value: useFake,
                onChanged: (v) => setState(() {
                  useFake = v;
                  message = useFake ? 'fake: hello' : 'api: hello from server';
                }),
              ),
              FilledButton(
                onPressed: () => setState(() {
                  message = useFake ? 'fake: hello #\${DateTime.now().second}' : 'api: hello #\${DateTime.now().second}';
                }),
                child: const Text('repo.fetch()'),
              ),
              const SizedBox(height: 8),
              TopicCode(message),
            ],
          ),
        ),`,
      {
        stateful: true,
        stateFields: "  bool useFake = true;\n  String message = 'fake: hello';\n",
      },
    );
  }

  if (t.includes('测试各层级')) {
    return scaffold(
      t,
      '按层测试：数据层单测、ViewModel 单测、UI Widget 测、少量集成测。',
      `        TopicSection(
          title: '测试金字塔',
          child: Column(
            children: [
              _bar('UI / 集成', 0.25, Colors.orange),
              _bar('Widget', 0.45, Colors.teal),
              _bar('单元（多）', 0.85, Colors.indigo),
              const SizedBox(height: 8),
              const Text('底层多、快；顶层少、慢但覆盖真实路径。'),
            ],
          ),
        ),`,
    ).replace(
      'Widget buildDemo() => const DemoPage();',
      `Widget _bar(String label, double w, Color c) => Padding(
  padding: const EdgeInsets.only(bottom: 8),
  child: Row(
    children: [
      SizedBox(width: 88, child: Text(label)),
      Expanded(
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: w,
          child: Container(height: 28, color: c.withValues(alpha: 0.7), alignment: Alignment.center, child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12))),
        ),
      ),
    ],
  ),
);

Widget buildDemo() => const DemoPage();`,
    );
  }

  if (t.includes('UI 层')) {
    return scaffold(
      t,
      'UI 层：展示状态、转发用户意图；不直接写 HTTP/SQL。',
      `        TopicSection(
          title: '单向数据流',
          child: Column(
            children: [
              _box(context, 'View (Widgets)', Theme.of(context).colorScheme.primaryContainer),
              const Text('↓ 事件 / ↑ 状态'),
              _box(context, 'ViewModel / Controller', Theme.of(context).colorScheme.secondaryContainer),
              const Text('↓ 调用'),
              _box(context, '（到数据层）', Theme.of(context).colorScheme.surfaceContainerHighest),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => setState(() => ticks++),
                child: Text('用户点击 → VM 处理（次数 \$ticks）'),
              ),
            ],
          ),
        ),`,
      { stateful: true, stateFields: '  int ticks = 0;\n' },
    ).replace(
      'Widget buildDemo() => const DemoPage();',
      `Widget _box(BuildContext context, String t, Color c) => Container(
  width: double.infinity,
  margin: const EdgeInsets.symmetric(vertical: 4),
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(8)),
  child: Text(t, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
);

Widget buildDemo() => const DemoPage();`,
    );
  }

  if (t.includes('数据层')) {
    return scaffold(
      t,
      '数据层：Repository 聚合 API / 缓存 / DB，对外提供领域模型。',
      `        TopicSection(
          title: 'Repository 扇入',
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _src(context, 'Remote API')),
                  Expanded(child: _src(context, 'Local DB')),
                  Expanded(child: _src(context, 'Cache')),
                ],
              ),
              const Icon(Icons.arrow_downward),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: const Text('UserRepository.getProfile()', textAlign: TextAlign.center),
              ),
              const Icon(Icons.arrow_downward),
              const Text('→ UI / ViewModel'),
            ],
          ),
        ),`,
    ).replace(
      'Widget buildDemo() => const DemoPage();',
      `Widget _src(BuildContext context, String t) => Container(
  margin: const EdgeInsets.all(4),
  padding: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    border: Border.all(color: Theme.of(context).dividerColor),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text(t, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
);

Widget buildDemo() => const DemoPage();`,
    );
  }

  if (t.includes('设计模式')) {
    return scaffold(
      t,
      'Flutter 常用：组合、观察者、仓库、依赖注入、命令/意图等。',
      `        TopicSection(
          title: '选择模式看说明',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 8,
                children: [
                  for (final p in patterns.keys)
                    ChoiceChip(
                      label: Text(p),
                      selected: sel == p,
                      onSelected: (_) => setState(() => sel = p),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(patterns[sel]!, style: const TextStyle(height: 1.45)),
            ],
          ),
        ),`,
      {
        stateful: true,
        stateFields: `  String sel = 'Repository';
  final patterns = <String, String>{
    'Repository': '隐藏数据来源，对上层提供稳定 API。',
    'Observer': 'ValueNotifier / Stream / Listenable 通知 UI。',
    'Command': '把用户操作封装成 Intent / Cubit event。',
    'DI': '构造注入依赖，便于替换实现。',
  };
`,
      },
    );
  }

  // 概览 / 理念 / 指南 / 建议 / 实践
  return scaffold(
    t,
    '清晰分层、单向数据流、可测试：让功能增长时结构仍可控。',
    `        TopicSection(
          title: '推荐分层',
          child: Column(
            children: [
              layer('UI 层', cs.primaryContainer),
              const Icon(Icons.south),
              layer('领域 / 用例（可选）', cs.secondaryContainer),
              const Icon(Icons.south),
              layer('数据层 Repository', cs.tertiaryContainer),
            ],
          ),
        ),
        TopicSection(
          title: '原则',
          child: TopicBulletList(const [
            'UI 只反映状态，不藏业务副作用',
            '边界明确：网络/DB 不泄漏到 Widget',
            '用接口 + DI 方便测试',
            '按功能分目录，避免「万能 utils」',
          ]),
        ),`,
  ).replace(
    '  Widget build(BuildContext context) {\n    return TopicDemoScaffold(',
    `  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    Widget layer(String name, Color c) => Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(10)),
      child: Text(name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
    return TopicDemoScaffold(`,
  );
}

// ===================== 03 平台集成 =====================

function genPlatform(m) {
  const t = m.title;

  if (t.includes('支持的平台') || t === '平台集成') {
    return scaffold(
      t,
      'Flutter 支持移动、桌面与 Web；各平台能力与发布流程略有差异。',
      `        TopicSection(
          title: '平台矩阵',
          child: Column(
            children: [
              for (final p in [
                ('Android', true),
                ('iOS', true),
                ('Web', true),
                ('Windows', true),
                ('macOS', true),
                ('Linux', true),
              ])
                ListTile(
                  leading: Icon(p.\$2 ? Icons.check_circle : Icons.cancel, color: p.\$2 ? Colors.green : Colors.grey),
                  title: Text(p.\$1),
                  subtitle: Text(p.\$2 ? '官方支持' : '受限'),
                ),
            ],
          ),
        ),`,
    );
  }

  if (t.includes('平台代码') || t.includes('插件') || t.includes('绑定') || t.includes('原生代码')) {
    return scaffold(
      t,
      'MethodChannel / EventChannel / FFI 让 Dart 调用原生，或嵌入原生视图。',
      `        TopicSection(
          title: 'MethodChannel 模拟',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: ctrl,
                decoration: const InputDecoration(labelText: 'invokeMethod 参数', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => setState(() {
                  log.add('Dart → native: getBattery(\${ctrl.text})');
                  log.add('native → Dart: 85%');
                }),
                child: const Text('channel.invokeMethod'),
              ),
              const SizedBox(height: 8),
              TopicCode(log.isEmpty ? '// 尚无调用' : log.join('\\n')),
            ],
          ),
        ),
        const TopicSection(
          title: '文档对应',
          child: TopicCode("static const ch = MethodChannel('demo/battery');\\nfinal level = await ch.invokeMethod('getBattery');"),
        ),`,
      {
        stateful: true,
        stateFields: "  final ctrl = TextEditingController(text: 'demo');\n  final log = <String>[];\n",
        methods: `  @override\n  void dispose() {\n    ctrl.dispose();\n    super.dispose();\n  }\n`,
      },
    );
  }

  if (t.includes('闪屏') || t.includes('启动页')) {
    return scaffold(
      t,
      '启动图在原生侧配置（Android 12 SplashScreen API / iOS LaunchScreen），Flutter 首帧前展示。',
      `        TopicSection(
          title: '启动闪屏预览',
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.blue.shade800, Colors.blue.shade400]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterLogo(size: 72),
                  SizedBox(height: 16),
                  Text('MyApp', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Launch / Splash', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
        ),`,
    );
  }

  if (t.includes('预测性返回')) {
    return scaffold(
      t,
      'Android 预测性返回：系统手势预览返回目标；Flutter 需启用并正确处理 Pop。',
      `        TopicSection(
          title: '返回手势示意',
          child: Column(
            children: [
              AnimatedSlide(
                offset: Offset(drag, 0),
                duration: const Duration(milliseconds: 50),
                child: Card(
                  child: SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: Center(child: Text(drag > 0.2 ? '即将 pop ←' : '从左缘右滑预览')),
                  ),
                ),
              ),
              Slider(value: drag, onChanged: (v) => setState(() => drag = v)),
              const Text('真实设备由系统驱动；应用侧确保路由可 pop。'),
            ],
          ),
        ),`,
      { stateful: true, stateFields: '  double drag = 0;\n' },
    );
  }

  if (t.includes('原生视图') || t.includes('托管')) {
    return scaffold(
      t,
      'AndroidView / UiKitView 把原生控件嵌进 Flutter 树（地图、广告等）。',
      `        TopicSection(
          title: 'Platform View 占位',
          child: Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,
            ),
            alignment: Alignment.center,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map, size: 40),
                Text('Native View (示意)\\n实际由 AndroidView 渲染'),
              ],
            ),
          ),
        ),`,
    );
  }

  if (t.includes('桌面') || t.includes('Windows') || t.includes('Web')) {
    return scaffold(
      t,
      t.includes('Web')
        ? 'Web 编译为 HTML/Canvas/WASM；注意 URL 策略、SEO 与插件兼容。'
        : '桌面端关注窗口、菜单、文件选择与多窗口体验。',
      `        TopicSection(
          title: '目标平台',
          child: Wrap(
            spacing: 8,
            children: [
              for (final p in ${t.includes('Web')
                  ? "['Chrome', 'Edge', 'Safari', 'Firefox']"
                  : "['Windows', 'macOS', 'Linux']"})
                FilterChip(
                  label: Text(p),
                  selected: selected.contains(p),
                  onSelected: (v) => setState(() {
                    if (v) {
                      selected.add(p);
                    } else {
                      selected.remove(p);
                    }
                  }),
                ),
            ],
          ),
        ),
        TopicSection(
          title: '常用命令',
          child: TopicCode('''${t.includes('Web')
              ? 'flutter run -d chrome\\nflutter build web'
              : 'flutter run -d windows\\nflutter build windows'}'''),
        ),`,
      { stateful: true, stateFields: '  final selected = <String>{};\n' },
    );
  }

  // Android/iOS 配置
  return scaffold(
    t,
    '在 android/ 或 ios/ 工程中配置 SDK、签名、权限与能力声明。',
    `        TopicSection(
          title: '配置检查清单',
          child: Column(
            children: [
              for (final item in items)
                CheckboxListTile(
                  dense: true,
                  title: Text(item),
                  value: done.contains(item),
                  onChanged: (v) => setState(() {
                    if (v == true) {
                      done.add(item);
                    } else {
                      done.remove(item);
                    }
                  }),
                ),
              Text('完成 \${done.length}/\${items.length}'),
            ],
          ),
        ),`,
    {
      stateful: true,
      stateFields: `  final items = const [
    '安装对应平台工具链',
    '接受许可证 / 证书',
    '配置签名或调试描述文件',
    '声明权限与隐私用途',
  ];
  final done = <String>{};
`,
    },
  );
}

// ===================== 04 Package =====================

function genPkg(m) {
  const t = m.title;
  const author = t.includes('作者') || t.includes('开发');
  const fav = t.includes('Favorites');

  if (fav) {
    return scaffold(
      t,
      'Flutter Favorites 是社区与团队认可的高质量 package 精选。',
      `        TopicSection(
          title: 'Favorites 示意列表',
          child: Column(
            children: [
              for (final p in ['provider', 'go_router', 'shared_preferences', 'url_launcher', 'flutter_bloc'])
                ListTile(
                  leading: const Icon(Icons.star, color: Colors.amber),
                  title: Text(p),
                  subtitle: const Text('Favorite（示意）'),
                ),
            ],
          ),
        ),`,
    );
  }

  if (author) {
    return scaffold(
      t,
      '开发 package/plugin：确定支持平台、实现通道、写好示例与文档。',
      `        TopicSection(
          title: '插件结构',
          child: const TopicCode('mypackage/\\n  lib/\\n  android/\\n  ios/\\n  pubspec.yaml'),
        ),
        const TopicSection(
          title: '要点',
          child: TopicBulletList([
            '明确支持的平台与最低系统版本',
            'MethodChannel / FFI 实现原生能力',
            '提供 example/ 与完善 README',
          ]),
        ),`,
    );
  }

  return scaffold(
    t,
    '在 pubspec.yaml 声明依赖，flutter pub get 拉取；插件含原生代码。',
    `        TopicSection(
          title: '添加依赖',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'package 名', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => setState(() {
                  if (name.text.trim().isEmpty) return;
                  deps.add(name.text.trim());
                  name.clear();
                }),
                child: const Text('flutter pub add（模拟）'),
              ),
              const SizedBox(height: 8),
              TopicCode(deps.isEmpty ? 'dependencies:' : 'dependencies:\\n\${deps.map((d) => '  \$d: any').join('\\n')}'),
            ],
          ),
        ),
        TopicSection(
          title: '本 App 已用',
          child: Wrap(
            spacing: 8,
            children: const [
              Chip(label: Text('go_router')),
              Chip(label: Text('flutter_markdown')),
            ],
          ),
        ),`,
    {
      stateful: true,
      stateFields: "  final name = TextEditingController();\n  final deps = <String>['go_router'];\n",
      methods: `  @override\n  void dispose() {\n    name.dispose();\n    super.dispose();\n  }\n`,
    },
  );
}

// ===================== 05 测试和调试 =====================

function genTest(m) {
  const t = m.title;

  if (t.includes('寻找') || t.includes('widgets') || t.includes('Widgets')) {
    return scaffold(
      t,
      'WidgetTester 用 find.text / find.byKey / find.byType 定位组件。',
      `        TopicSection(
          title: '被测树',
          child: Column(
            children: [
              Text('Hello', key: const Key('hello')),
              IconButton(key: const Key('fab'), icon: const Icon(Icons.add), onPressed: () {}),
              const FlutterLogo(),
            ],
          ),
        ),
        TopicSection(
          title: 'Finder 结果（模拟）',
          child: Column(
            children: [
              for (final f in [
                ("find.text('Hello')", 'findsOneWidget'),
                ("find.byKey(Key('fab'))", 'findsOneWidget'),
                ("find.byType(FlutterLogo)", 'findsOneWidget'),
                ("find.text('Missing')", 'findsNothing'),
              ])
                ListTile(dense: true, title: Text(f.\$1, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)), trailing: Text(f.\$2)),
            ],
          ),
        ),`,
    );
  }

  if (t.includes('模拟滚动')) {
    return scaffold(
      t,
      'tester.drag / fling 模拟滚动，再 expect 可见项。',
      `        TopicSection(
          title: '可滚动列表（请手势滚动）',
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (_, i) => ListTile(title: Text('Item \$i', key: ValueKey('item-\$i'))),
            ),
          ),
        ),
        const TopicSection(
          title: '测试代码',
          child: TopicCode("await tester.drag(find.byType(ListView), Offset(0, -300));\\nawait tester.pumpAndSettle();"),
        ),`,
    );
  }

  if (t.includes('模拟用户操作') || t.includes('用户操作')) {
    return scaffold(
      t,
      'tap、enterText、longPress 等模拟用户；每次操作后 pump。',
      `        TopicSection(
          title: '可操作控件',
          child: Column(
            children: [
              TextField(
                controller: ctrl,
                decoration: const InputDecoration(labelText: '输入', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => setState(() => msg = '提交: \${ctrl.text}'),
                child: const Text('提交'),
              ),
              Text(msg.isEmpty ? '等待操作' : msg),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  ctrl.text = 'from test';
                  setState(() => msg = '模拟 enterText + tap → 提交: from test');
                },
                child: const Text('一键模拟 tester 操作'),
              ),
            ],
          ),
        ),`,
      {
        stateful: true,
        stateFields: "  final ctrl = TextEditingController();\n  String msg = '';\n",
        methods: `  @override\n  void dispose() {\n    ctrl.dispose();\n    super.dispose();\n  }\n`,
      },
    );
  }

  if (t.includes('模拟依赖')) {
    return scaffold(
      t,
      '单元测试用 Fake/Mock 替换网络与时钟，断言逻辑而非 IO。',
      `        TopicSection(
          title: 'Clock 依赖替换',
          child: Column(
            children: [
              SwitchListTile(
                title: Text(useFake ? 'FakeClock = 2020-01-01' : '真实 DateTime.now()'),
                value: useFake,
                onChanged: (v) => setState(() => useFake = v),
              ),
              Text('业务看到的「今天」:\\n\${useFake ? '2020-01-01' : DateTime.now().toIso8601String().substring(0, 10)}',
                  textAlign: TextAlign.center),
            ],
          ),
        ),`,
      { stateful: true, stateFields: '  bool useFake = true;\n' },
    );
  }

  if (t.includes('单元测试')) {
    return scaffold(
      t,
      '纯 Dart test()：无 Widget 绑定，跑得最快。',
      `        TopicSection(
          title: '迷你测试运行器',
          child: Column(
            children: [
              ListTile(
                title: const Text('expect(1+1, 2)'),
                trailing: Icon(passAdd ? Icons.check : Icons.close, color: passAdd ? Colors.green : Colors.red),
              ),
              ListTile(
                title: const Text("expect(String.fromCharCodes([97,98]), 'ab')"),
                trailing: Icon(passStr ? Icons.check : Icons.close, color: passStr ? Colors.green : Colors.red),
              ),
              FilledButton(
                onPressed: () => setState(() {
                  passAdd = 1 + 1 == 2;
                  passStr = 'ab' == 'ab';
                }),
                child: const Text('运行 flutter test（模拟）'),
              ),
            ],
          ),
        ),`,
      { stateful: true, stateFields: '  bool passAdd = false;\n  bool passStr = false;\n' },
    );
  }

  if (t.includes('Widget 测试')) {
    return scaffold(
      t,
      'testWidgets 泵入 Widget 树，用 Finder 断言 UI。',
      `        TopicSection(
          title: '泵入示例',
          child: Card(
            child: ListTile(
              title: const Text('Counter'),
              subtitle: Text('value=\$n'),
              trailing: IconButton(icon: const Icon(Icons.add), onPressed: () => setState(() => n++)),
            ),
          ),
        ),
        const TopicSection(
          title: '对应测试',
          child: TopicCode("await tester.pumpWidget(MaterialApp(home: Counter()));\\nawait tester.tap(find.byIcon(Icons.add));\\nawait tester.pump();\\nexpect(find.text('value=1'), findsOneWidget);"),
        ),`,
      { stateful: true, stateFields: '  int n = 0;\n' },
    );
  }

  if (t.includes('集成测试')) {
    return scaffold(
      t,
      '集成测试在真机/模拟器跑完整 App，验证关键用户路径。',
      `        TopicSection(
          title: '关键路径步骤',
          child: Column(
            children: [
              for (var i = 0; i < steps.length; i++)
                CheckboxListTile(
                  title: Text(steps[i]),
                  value: i < done,
                  onChanged: (_) => setState(() => done = i + 1),
                ),
              Text(done >= steps.length ? '全部通过 ✓' : '进度 \$done/\${steps.length}'),
            ],
          ),
        ),
        const TopicSection(
          title: '命令',
          child: TopicCode('flutter test integration_test/app_test.dart'),
        ),`,
      {
        stateful: true,
        stateFields: `  final steps = const ['启动 App', '登录', '打开列表', '创建条目'];
  int done = 0;
`,
      },
    );
  }

  if (t.includes('调试工具') || t.includes('调试') || t.includes('通过代码')) {
    return scaffold(
      t,
      'DevTools、断点、logging、debugPrint；性能页看 Timeline。',
      `        TopicSection(
          title: '工具箱',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final x in ['Inspector', 'Performance', 'Memory', 'Network', 'Logging'])
                FilterChip(
                  label: Text(x),
                  selected: on.contains(x),
                  onSelected: (v) => setState(() {
                    if (v) {
                      on.add(x);
                    } else {
                      on.remove(x);
                    }
                  }),
                ),
            ],
          ),
        ),
        TopicSection(
          title: '代码侧',
          child: FilledButton(
            onPressed: () {
              debugPrint('demo debugPrint at \${DateTime.now()}');
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已 debugPrint（见控制台）')));
            },
            child: const Text('触发 debugPrint'),
          ),
        ),`,
      { stateful: true, stateFields: "  final on = <String>{'Inspector'};\n" },
    );
  }

  if (t.includes('常见') && t.includes('错误') || t.includes('常见的 Flutter')) {
    return scaffold(
      t,
      '认识常见断言：RenderFlex overflow、setState after dispose、无限宽高等。',
      `        TopicSection(
          title: '点选查看原因与修法',
          child: Column(
            children: [
              for (final e in errors.entries)
                ExpansionTile(
                  title: Text(e.key, style: const TextStyle(fontSize: 14)),
                  children: [Padding(padding: const EdgeInsets.all(12), child: Text(e.value))],
                ),
            ],
          ),
        ),`,
      {
        stateful: true,
        stateFields: `  final errors = const {
    'A RenderFlex overflowed': 'Row/Column 子项过大 → 用 Expanded/Flexible/换行或约束宽度。',
    'setState() called after dispose()': '异步回调先检查 mounted，或取消订阅。',
    'Vertical viewport was given unbounded height': 'ListView 放在无界高度父级 → 给高度或用 shrinkWrap/Expanded。',
  };
`,
      },
    );
  }

  if (t.includes('处理错误')) {
    return scaffold(
      t,
      'FlutterError.onError、PlatformDispatcher.instance.onError 统一上报；UI 用错误状态展示。',
      `        TopicSection(
          title: '安全演示错误区',
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('展示错误占位 UI'),
                value: showErr,
                onChanged: (v) => setState(() => showErr = v),
              ),
              if (showErr)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Column(
                    children: [
                      Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error),
                      const Text('出错了，请重试'),
                      TextButton(onPressed: () => setState(() => showErr = false), child: const Text('重试')),
                    ],
                  ),
                )
              else
                const Text('正常内容'),
            ],
          ),
        ),`,
      { stateful: true, stateFields: '  bool showErr = false;\n' },
    );
  }

  // 测试概览 / 模块入口
  return scaffold(
    t,
    '测试金字塔 + 调试工具，保证重构与发布信心。',
    `        TopicSection(
          title: '三层测试',
          child: Column(
            children: [
              for (final x in [
                ('单元测试', '纯逻辑', Icons.science),
                ('Widget 测试', 'UI 组件', Icons.widgets),
                ('集成测试', '端到端', Icons.devices),
              ])
                ListTile(
                  leading: Icon(x.\$3),
                  title: Text(x.\$1),
                  subtitle: Text(x.\$2),
                ),
            ],
          ),
        ),`,
  );
}

// ===================== 06 性能 =====================

function genPerf(m) {
  const t = m.title;

  if (t.includes('Impeller')) {
    return scaffold(
      t,
      'Impeller 预编译着色器，减少运行时卡顿；逐步成为默认渲染后端。',
      `        TopicSection(
          title: '渲染后端对照（概念）',
          child: Column(
            children: [
              RadioListTile<String>(
                title: const Text('Impeller'),
                subtitle: const Text('减少 jank · 预编译'),
                value: 'impeller',
                groupValue: eng,
                onChanged: (v) => setState(() => eng = v!),
              ),
              RadioListTile<String>(
                title: const Text('Skia'),
                subtitle: const Text('传统路径 · 运行时编译着色器'),
                value: 'skia',
                groupValue: eng,
                onChanged: (v) => setState(() => eng = v!),
              ),
              Text('当前示意: \$eng'),
            ],
          ),
        ),`,
      { stateful: true, stateFields: "  String eng = 'impeller';\n" },
    );
  }

  if (t.includes('应用大小')) {
    return scaffold(
      t,
      '拆分 ABI、压缩资源、延迟组件、去除无用代码，减小安装包。',
      `        TopicSection(
          title: '体积构成（示意 MB）',
          child: Column(
            children: [
              for (final e in [
                ('Dart code', code),
                ('Assets', assets),
                ('Native libs', native),
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      SizedBox(width: 88, child: Text(e.\$1)),
                      Expanded(
                        child: LinearProgressIndicator(value: e.\$2 / 40, minHeight: 14),
                      ),
                      const SizedBox(width: 8),
                      Text(e.\$2.toStringAsFixed(0)),
                    ],
                  ),
                ),
              Text('合计 ~ \${(code + assets + native).toStringAsFixed(0)} MB'),
              Slider(value: assets, min: 2, max: 20, label: 'assets', onChanged: (v) => setState(() => assets = v)),
              const Text('拖动模拟压缩资源后的体积变化'),
            ],
          ),
        ),`,
      { stateful: true, stateFields: '  double code = 12;\n  double assets = 8;\n  double native = 15;\n' },
    );
  }

  if (t.includes('并发') || t.includes('隔离')) {
    return scaffold(
      t,
      '重计算放到 isolate，避免阻塞 UI；简单场景可用 compute。',
      `        TopicSection(
          title: '阻塞对比（模拟）',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('帧计数动画: \$frames'),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: busy
                    ? null
                    : () async {
                        setState(() => busy = true);
                        // 不真正卡死 UI：用分片延迟模拟「后台」完成
                        await Future<void>.delayed(const Duration(milliseconds: 900));
                        if (!mounted) return;
                        setState(() { busy = false; result = 'isolate 完成 heavyWork()'; });
                      },
                child: const Text('Isolate.run(heavyWork)'),
              ),
              if (busy) const LinearProgressIndicator(),
              if (result != null) Text(result!),
              const Text('同时观察上方数字仍在（UI isolate 未死锁）。'),
            ],
          ),
        ),`,
      {
        stateful: true,
        stateFields: '  int frames = 0;\n  bool busy = false;\n  String? result;\n',
        methods: `  @override
  void initState() {
    super.initState();
    Future.doWhile(() async {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      if (!mounted) return false;
      setState(() => frames++);
      return true;
    });
  }
`,
      },
    );
  }

  if (t.includes('延迟')) {
    return scaffold(
      t,
      '延迟加载：首屏不建昂贵子树；或 deferred import 拆包。',
      `        TopicSection(
          title: '按需构建重列表',
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('加载 500 行列表'),
                value: show,
                onChanged: (v) => setState(() => show = v),
              ),
              if (show)
                SizedBox(
                  height: 220,
                  child: ListView.builder(itemCount: 500, itemBuilder: (_, i) => ListTile(dense: true, title: Text('row \$i'))),
                )
              else
                const Text('未加载 → 首帧更轻'),
            ],
          ),
        ),`,
      { stateful: true, stateFields: '  bool show = false;\n' },
    );
  }

  if (t.includes('分析')) {
    return scaffold(
      t,
      'Profile 模式 + DevTools Performance，找 build/layout/paint 耗时。',
      `        TopicSection(
          title: '检查清单',
          child: Column(
            children: [
              for (final s in checks)
                CheckboxListTile(
                  dense: true,
                  title: Text(s),
                  value: done.contains(s),
                  onChanged: (v) => setState(() {
                    if (v == true) {
                      done.add(s);
                    } else {
                      done.remove(s);
                    }
                  }),
                ),
            ],
          ),
        ),
        const TopicSection(title: '命令', child: TopicCode('flutter run --profile\\n# 打开 DevTools → Performance')),`,
      {
        stateful: true,
        stateFields: `  final checks = const [
    '用 Profile 而非 Debug 测帧时',
    '打开 Performance overlay',
    'Timeline 找长任务',
    '缩小 rebuild 范围',
  ];
  final done = <String>{};
`,
      },
    );
  }

  // 渲染 / 最佳实践 / 概览
  return scaffold(
    t,
    '长列表用 builder；减小重建；避免过深透明度与巨大图片。',
    `        TopicSection(
          title: 'ListView 策略',
          child: Column(
            children: [
              SwitchListTile(
                title: Text(builder ? 'ListView.builder（懒加载）' : '一次性 children'),
                value: builder,
                onChanged: (v) => setState(() => builder = v),
              ),
              SizedBox(
                height: 180,
                child: builder
                    ? ListView.builder(itemCount: 1000, itemBuilder: (_, i) => ListTile(dense: true, title: Text('lazy \$i')))
                    : ListView(children: [for (var i = 0; i < 60; i++) ListTile(dense: true, title: Text('eager \$i'))]),
              ),
            ],
          ),
        ),`,
    { stateful: true, stateFields: '  bool builder = true;\n' },
  );
}

// ===================== 07 打包部署 =====================

function genDeploy(m) {
  const t = m.title;

  if (t.includes('flavor')) {
    return scaffold(
      t,
      'Flavor / 产品风味：同一代码多环境（dev/staging/prod）包名、图标、API。',
      `        TopicSection(
          title: '切换 Flavor',
          child: Column(
            children: [
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'dev', label: Text('dev')),
                  ButtonSegment(value: 'staging', label: Text('staging')),
                  ButtonSegment(value: 'prod', label: Text('prod')),
                ],
                selected: {flavor},
                onSelectionChanged: (s) => setState(() => flavor = s.first),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: flavor == 'prod' ? Colors.green.shade100 : flavor == 'staging' ? Colors.orange.shade100 : Colors.blue.shade100,
                child: Column(
                  children: [
                    Text('App (\$flavor)', style: Theme.of(context).textTheme.headlineSmall),
                    Text('api: https://api.\$flavor.example.com'),
                    Text('applicationId suffix: .\$flavor'),
                  ],
                ),
              ),
            ],
          ),
        ),`,
      { stateful: true, stateFields: "  String flavor = 'dev';\n" },
    );
  }

  if (t.includes('混淆')) {
    return scaffold(
      t,
      '释放构建可混淆 Dart 符号，减小逆向可读性；需保存 debug info。',
      `        TopicSection(
          title: '符号对照',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SwitchListTile(
                title: const Text('启用 obfuscate'),
                value: on,
                onChanged: (v) => setState(() => on = v),
              ),
              TopicCode(on ? 'a.b.c.X#y\\na.b.c.Z#w' : 'MyService.fetchUser()\\nHomePageState.build()'),
              const TopicCode('flutter build apk --obfuscate --split-debug-info=build/symbols'),
            ],
          ),
        ),`,
      { stateful: true, stateFields: '  bool on = false;\n' },
    );
  }

  if (t.includes('持续部署') || t.includes('持续')) {
    return scaffold(
      t,
      'CI/CD：提交 → 测试 → 构建 → 分发（内测/商店）。',
      `        TopicSection(
          title: '流水线',
          child: Column(
            children: [
              for (var i = 0; i < stages.length; i++)
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: i < step ? Colors.green : Colors.grey.shade300,
                    child: Text('\${i + 1}'),
                  ),
                  title: Text(stages[i]),
                ),
              FilledButton(
                onPressed: () => setState(() => step = (step % (stages.length + 1)) + (step >= stages.length ? 0 : 1)),
                child: Text(step >= stages.length ? '重置' : '推进一步'),
              ),
            ],
          ),
        ),`,
      {
        stateful: true,
        stateFields: `  final stages = const ['checkout', 'flutter test', 'build', 'upload'];
  int step = 0;
`,
      },
    );
  }

  // 构建发布各平台 / 概览
  const platform = t.includes('iOS') ? 'ipa' : t.includes('Web') ? 'web' : t.includes('Android') ? 'appbundle' : 'release';
  return scaffold(
    t,
    '使用 flutter build 产出发布产物，再提交商店或托管静态资源。',
    `        TopicSection(
          title: '构建步骤',
          child: Column(
            children: [
              for (var i = 0; i < steps.length; i++)
                CheckboxListTile(
                  title: Text(steps[i]),
                  value: i < done,
                  onChanged: (_) => setState(() => done = (i + 1).clamp(0, steps.length)),
                ),
              TopicCode('flutter build ${platform} --release'),
            ],
          ),
        ),`,
    {
      stateful: true,
      stateFields: `  final steps = const ['版本号 / 签名就绪', 'flutter build', '产物自检', '上传商店或 CDN'];
  int done = 0;
`,
    },
  );
}

// ===================== 08 Add to app =====================

function genAddToApp(m) {
  const t = m.title;

  if (t.includes('Fragment')) {
    return scaffold(
      t,
      'Android 可用 FlutterFragment 嵌入现有 Activity 的一部分区域。',
      `        TopicSection(
          title: 'Activity 内嵌 Fragment 示意',
          child: Container(
            height: 240,
            decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Container(height: 40, color: Colors.blueGrey.shade100, alignment: Alignment.center, child: const Text('Native AppBar')),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Container(color: Colors.grey.shade200, alignment: Alignment.center, child: const Text('Native'))),
                      Expanded(
                        child: Container(
                          color: Colors.blue.shade50,
                          alignment: Alignment.center,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [FlutterLogo(), Text('FlutterFragment')],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),`,
    );
  }

  if (t.includes('多个 Flutter') || t.includes('多')) {
    return scaffold(
      t,
      '多 FlutterEngine 成本高；优先复用引擎或 FlutterEngineGroup。',
      `        TopicSection(
          title: '引擎策略',
          child: Column(
            children: [
              RadioListTile<String>(
                title: const Text('单引擎复用'),
                subtitle: const Text('推荐 · 省内存'),
                value: 'single',
                groupValue: mode,
                onChanged: (v) => setState(() => mode = v!),
              ),
              RadioListTile<String>(
                title: const Text('多实例 / 多引擎'),
                subtitle: const Text('隔离强 · 更耗资源'),
                value: 'multi',
                groupValue: mode,
                onChanged: (v) => setState(() => mode = v!),
              ),
              Text(mode == 'single' ? 'Host ↔ 共享 Engine ↔ 多个入口' : 'Host ↔ EngineA + EngineB …'),
            ],
          ),
        ),`,
      { stateful: true, stateFields: "  String mode = 'single';\n" },
    );
  }

  if (t.includes('调试')) {
    return scaffold(
      t,
      '调试内嵌 module：附加调试器到 Flutter 进程，使用 DevTools。',
      `        TopicSection(
          title: '调试连接示意',
          child: Column(
            children: [
              ListTile(leading: const Icon(Icons.phone_android), title: const Text('Host App'), subtitle: Text(attached ? '已附加' : '未附加')),
              ListTile(leading: const Icon(Icons.flutter_dash), title: const Text('Flutter module'), subtitle: const Text('observatory / VM service')),
              FilledButton(
                onPressed: () => setState(() => attached = !attached),
                child: Text(attached ? '断开调试' : '附加调试器'),
              ),
            ],
          ),
        ),`,
      { stateful: true, stateFields: '  bool attached = false;\n' },
    );
  }

  // 概览 / 工程设定 / 添加页面
  return scaffold(
    t,
    'Add-to-app：Flutter module 嵌入既有 Android / iOS 应用，而不是替换整个 App。',
    `        TopicSection(
          title: '宿主 + Flutter',
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.blueGrey.shade100,
                child: const Text('Native Host (Java/Kotlin/Swift/OC)', textAlign: TextAlign.center),
              ),
              const Icon(Icons.swap_vert),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.blue.shade50,
                child: const Column(
                  children: [
                    FlutterLogo(size: 40),
                    Text('Flutter Module'),
                    Text('FlutterActivity / ViewController', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              TopicCode('flutter create -t module my_flutter'),
            ],
          ),
        ),`,
  );
}

function generate(m) {
  const folder = m.moduleFolder || '';
  if (folder.includes('01-') || m.module.includes('数据')) return genData(m);
  if (folder.includes('02-') || m.module.includes('架构')) return genArch(m);
  if (folder.includes('03-') || m.module.includes('平台')) return genPlatform(m);
  if (folder.includes('04-') || m.module.includes('Package')) return genPkg(m);
  if (folder.includes('05-') || m.module.includes('测试')) return genTest(m);
  if (folder.includes('06-') || m.module.includes('性能')) return genPerf(m);
  if (folder.includes('07-') || m.module.includes('打包')) return genDeploy(m);
  if (folder.includes('08-') || m.module.includes('现有') || m.module.includes('添加')) return genAddToApp(m);
  return genData(m);
}

let ok = 0;
for (const m of META) {
  const content = generate(m);
  writeDemo(m.n, content);
  try {
    syncExample(m, content);
  } catch (_) {}
  ok++;
}
console.log('beyond-ui demos:', ok);
