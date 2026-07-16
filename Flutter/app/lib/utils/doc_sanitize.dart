/// 清理官方文档 Markdown 开头的重复标题、抓取元信息与 front-matter，
/// 并规范段落空行，改善排版拥挤。
String sanitizeDocMarkdown(String input) {
  var text = input.replaceAll('\r\n', '\n');

  var changed = true;
  while (changed) {
    changed = false;
    text = text.replaceFirst(RegExp(r'^\s+'), '');

    if (text.startsWith('[TOC]')) {
      text = text.substring(5);
      changed = true;
      continue;
    }

    final h1 = RegExp(r'^#\s+[^\n]+\n*');
    if (h1.hasMatch(text)) {
      text = text.replaceFirst(h1, '');
      changed = true;
      continue;
    }

    final bq = RegExp(r'^(?:>\s?[^\n]*\n)+');
    if (bq.hasMatch(text)) {
      text = text.replaceFirst(bq, '');
      changed = true;
      continue;
    }

    final hr = RegExp(r'^---+\s*\n*');
    if (hr.hasMatch(text)) {
      text = text.replaceFirst(hr, '');
      changed = true;
      continue;
    }

    final frontMatter = RegExp(
      r'^(?:(?:#[^\n]*|[A-Za-z0-9_-]+\s*:[^\n]*)\n)+---+\s*\n*',
    );
    if (frontMatter.hasMatch(text)) {
      text = text.replaceFirst(frontMatter, '');
      changed = true;
      continue;
    }

    final directive = RegExp(r'^<\?code-excerpt[^?]*\?>\s*\n*');
    if (directive.hasMatch(text)) {
      text = text.replaceFirst(directive, '');
      changed = true;
      continue;
    }
  }

  text = text.replaceAll(RegExp(r'<\?code-excerpt[^?]*\?>\s*'), '');
  text = text.replaceAll('\uFFFD', '');

  text = text.replaceAllMapped(
    RegExp(
      r'^:::(note|warning|tip|important|secondary)[^\n]*\n([\s\S]*?)^:::\s*$',
      multiLine: true,
    ),
    (m) {
      final body = m[2]!.trim().split('\n').map((l) => '> $l').join('\n');
      return '> **${m[1]}**\n$body\n';
    },
  );

  return normalizeMarkdownLayout(text);
}

/// 为标题、代码块、中英段落补充空行，使排版更接近常见 Markdown 预览。
String normalizeMarkdownLayout(String input) {
  var text = input.replaceAll('\r\n', '\n').trim();

  // 标题前后至少一空行
  text = text.replaceAllMapped(
    RegExp(r'([^\n])\n(#{1,6}\s)'),
    (m) => '${m[1]}\n\n${m[2]}',
  );
  text = text.replaceAllMapped(
    RegExp(r'^(#{1,6}[^\n]+)\n(?!\n|#|```)', multiLine: true),
    (m) => '${m[1]}\n\n',
  );

  // 代码围栏前后空行
  text = text.replaceAllMapped(
    RegExp(r'([^\n])\n(```)'),
    (m) => '${m[1]}\n\n${m[2]}',
  );
  text = text.replaceAllMapped(
    RegExp(r'(```)\n([^\n`])'),
    (m) => '${m[1]}\n\n${m[2]}',
  );

  // 列表块与上文之间空行
  text = text.replaceAllMapped(
    RegExp(r'([^\n])\n([-*+] |\d+\. )'),
    (m) => '${m[1]}\n\n${m[2]}',
  );

  // 引用块与上文之间空行
  text = text.replaceAllMapped(
    RegExp(r'([^\n])\n(> )'),
    (m) => '${m[1]}\n\n${m[2]}',
  );

  // 中英混排：相邻的「偏西文行」与「偏中文行」拆成独立段落
  final lines = text.split('\n');
  final out = <String>[];
  var inCode = false;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    final trimmed = line.trimRight();

    if (trimmed.startsWith('```')) {
      inCode = !inCode;
      out.add(line);
      continue;
    }
    if (inCode) {
      out.add(line);
      continue;
    }

    out.add(line);

    if (i >= lines.length - 1) continue;
    final next = lines[i + 1];
    if (trimmed.isEmpty || next.trim().isEmpty) continue;
    if (_isMarkdownStructure(trimmed) || _isMarkdownStructure(next.trim())) {
      continue;
    }

    final curScript = _lineScript(trimmed);
    final nextScript = _lineScript(next.trim());
    if (curScript != _Script.mixed &&
        nextScript != _Script.mixed &&
        curScript != nextScript) {
      out.add('');
    }
  }

  text = out.join('\n');
  // 压缩多余空行，保留段落间距
  text = text.replaceAll(RegExp(r'\n{3,}'), '\n\n');
  return text.trim();
}

enum _Script { cjk, latin, mixed }

bool _isMarkdownStructure(String line) {
  return RegExp(
    r'^(#{1,6}\s|```|> |[-*+] |\d+\. |\||={3,}|-{3,})',
  ).hasMatch(line);
}

_Script _lineScript(String line) {
  var cjk = 0;
  var latin = 0;
  for (final rune in line.runes) {
    final ch = String.fromCharCode(rune);
    if (RegExp(r'[\u4e00-\u9fff]').hasMatch(ch)) {
      cjk++;
    } else if (RegExp(r'[A-Za-z]').hasMatch(ch)) {
      latin++;
    }
  }
  if (cjk == 0 && latin == 0) return _Script.mixed;
  if (cjk > 0 && latin == 0) return _Script.cjk;
  if (latin > 0 && cjk == 0) return _Script.latin;
  // 中英混在同一行视为 mixed，不强行拆段
  if (cjk >= latin * 2) return _Script.cjk;
  if (latin >= cjk * 2) return _Script.latin;
  return _Script.mixed;
}
