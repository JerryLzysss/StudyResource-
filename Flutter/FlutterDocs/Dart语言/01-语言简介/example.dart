import 'package:flutter/material.dart';

/// 语言简介 — 变量 / 函数 / 类 / 枚举 / Mixin 概念演示

enum PlanetType { terrestrial, gas, ice }

enum Planet {
  mercury(planetType: PlanetType.terrestrial, moons: 0),
  earth(planetType: PlanetType.terrestrial, moons: 1),
  jupiter(planetType: PlanetType.gas, moons: 95),
  neptune(planetType: PlanetType.ice, moons: 14);

  const Planet({required this.planetType, required this.moons});
  final PlanetType planetType;
  final int moons;
  bool get isGiant => planetType == PlanetType.gas || planetType == PlanetType.ice;
}

class Spacecraft {
  Spacecraft(this.name, this.launchDate);
  Spacecraft.unlaunched(String name) : this(name, null);

  final String name;
  final DateTime? launchDate;
  int? get launchYear => launchDate?.year;

  String describe() {
    if (launchDate == null) return '$name（未发射）';
    final years = DateTime.now().difference(launchDate!).inDays ~/ 365;
    return '$name · 发射于 $launchYear（约 $years 年前）';
  }
}

mixin Piloted {
  int astronauts = 3;
  String describeCrew() => '宇航员: $astronauts';
}

class PilotedCraft extends Spacecraft with Piloted {
  PilotedCraft(super.name, super.launchDate);
}

int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int _fibN = 10;
  Planet _planet = Planet.earth;
  late final Spacecraft _voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
  late final PilotedCraft _crew = PilotedCraft('Crew Dragon', DateTime(2020, 5, 30));

  @override
  Widget build(BuildContext context) {
    return DartDemoFrame(
      title: '语言简介',
      subtitle: '变量推断、递归函数、类 / 枚举 / Mixin 一览',
      children: [
        DemoSection(
          title: '变量与类型推断',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine("var name = 'Dash';\nvar year = 1977;"),
              const SizedBox(height: 8),
              Text('name → String，year → int（由初始化推断）'),
            ],
          ),
        ),
        DemoSection(
          title: '函数：fibonacci($_fibN) = ${fibonacci(_fibN)}',
          child: Column(
            children: [
              const CodeLine('int fibonacci(int n) => n < 2 ? n : fib(n-1)+fib(n-2);'),
              Slider(
                value: _fibN.toDouble(),
                min: 0,
                max: 20,
                divisions: 20,
                label: '$_fibN',
                onChanged: (v) => setState(() => _fibN = v.round()),
              ),
            ],
          ),
        ),
        DemoSection(
          title: '类：${_voyager.describe()}',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine("Spacecraft('Voyager I', DateTime(1977, 9, 5))"),
              const SizedBox(height: 8),
              Text(_crew.describe()),
              Text(_crew.describeCrew()),
            ],
          ),
        ),
        DemoSection(
          title: '增强枚举 Planet',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                children: Planet.values.map((p) {
                  return ChoiceChip(
                    label: Text(p.name),
                    selected: _planet == p,
                    onSelected: (_) => setState(() => _planet = p),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              Text('类型: ${_planet.planetType.name} · 卫星: ${_planet.moons} · 巨行星: ${_planet.isGiant}'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();

// --- 本地预览用 UI 辅助（与 demo_app 中 dart_demo_frame 一致）---
/// Dart 示例如统一外框：标题区 + 可滚动内容块。
class DartDemoFrame extends StatelessWidget {
  const DartDemoFrame({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class DemoSection extends StatelessWidget {
  const DemoSection({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class CodeLine extends StatelessWidget {
  const CodeLine(this.code, {super.key});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(code, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
    );
  }
}

