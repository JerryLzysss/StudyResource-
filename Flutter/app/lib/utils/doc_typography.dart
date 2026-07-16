import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// 文档 / 代码共用的本地字体族（勿用 Google Fonts 同名，以免 Web 联网拉取）。
const String kDocFontFamily = 'AppNotoSansSC';

const List<String> kDocFontFallback = [
  'AppRoboto',
  'Segoe UI Emoji',
  'Segoe UI Symbol',
  'Apple Color Emoji',
  'Arial Unicode MS',
];

TextStyle docTextStyle(TextStyle? base) {
  final style = base ?? const TextStyle();
  return style.copyWith(
    fontFamily: kDocFontFamily,
    fontFamilyFallback: kDocFontFallback,
  );
}

/// 代码样式：西文等宽优先，缺字时回退 Noto（覆盖代码注释中的中文）。
TextStyle codeTextStyle(TextStyle? base) {
  final style = base ?? const TextStyle(fontSize: 13.5, height: 1.55);
  return style.copyWith(
    fontFamily: 'AppRoboto',
    fontFamilyFallback: [
      kDocFontFamily,
      'Consolas',
      'Courier New',
      ...kDocFontFallback,
    ],
  );
}

/// 官方文档 Markdown 排版：段落行高、块间距、标题上下边距贴近常见 Markdown 预览。
MarkdownStyleSheet docMarkdownStyle(BuildContext context) {
  final theme = Theme.of(context);
  final scheme = theme.colorScheme;
  final sheet = MarkdownStyleSheet.fromTheme(theme);

  TextStyle t(TextStyle? s, {double? height, FontWeight? weight, double? size}) {
    return docTextStyle(s).copyWith(
      height: height,
      fontWeight: weight,
      fontSize: size ?? s?.fontSize,
    );
  }

  final body = t(
    theme.textTheme.bodyMedium,
    height: 1.75,
    size: 15,
  );
  final inlineCode = codeTextStyle(theme.textTheme.bodySmall).copyWith(
    fontSize: 13.5,
    height: 1.45,
    color: scheme.onSurface,
    backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.85),
  );

  return sheet.copyWith(
    // —— 正文 ——
    p: body,
    pPadding: const EdgeInsets.only(bottom: 10),
    blockSpacing: 14,

    // —— 标题（上留空、下紧跟正文）——
    h1: t(theme.textTheme.headlineMedium, height: 1.35, weight: FontWeight.w700, size: 28),
    h1Padding: const EdgeInsets.only(top: 20, bottom: 12),
    h2: t(theme.textTheme.titleLarge, height: 1.4, weight: FontWeight.w700, size: 22),
    h2Padding: const EdgeInsets.only(top: 24, bottom: 10),
    h3: t(theme.textTheme.titleMedium, height: 1.4, weight: FontWeight.w600, size: 18),
    h3Padding: const EdgeInsets.only(top: 20, bottom: 8),
    h4: t(theme.textTheme.titleSmall, height: 1.4, weight: FontWeight.w600, size: 16),
    h4Padding: const EdgeInsets.only(top: 16, bottom: 6),
    h5: t(theme.textTheme.titleSmall, height: 1.4, weight: FontWeight.w600),
    h5Padding: const EdgeInsets.only(top: 14, bottom: 4),
    h6: t(theme.textTheme.titleSmall, height: 1.4, weight: FontWeight.w600),
    h6Padding: const EdgeInsets.only(top: 12, bottom: 4),

    // —— 强调 / 链接 ——
    em: body.copyWith(fontStyle: FontStyle.italic),
    strong: body.copyWith(fontWeight: FontWeight.w700),
    del: body.copyWith(
      decoration: TextDecoration.lineThrough,
      color: scheme.onSurfaceVariant,
    ),
    a: body.copyWith(
      color: scheme.primary,
      decoration: TextDecoration.underline,
      decorationColor: scheme.primary.withValues(alpha: 0.5),
    ),

    // —— 列表 ——
    listIndent: 28,
    listBullet: body.copyWith(fontWeight: FontWeight.w600),
    listBulletPadding: const EdgeInsets.only(right: 10, top: 2),

    // —— 引用 ——
    blockquote: body.copyWith(
      color: scheme.onSurfaceVariant,
      height: 1.7,
    ),
    blockquotePadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
    blockquoteDecoration: BoxDecoration(
      color: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
      border: Border(
        left: BorderSide(color: scheme.primary.withValues(alpha: 0.65), width: 4),
      ),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(6),
        bottomRight: Radius.circular(6),
      ),
    ),

    // —— 行内 / 块代码 ——
    code: inlineCode,
    codeblockPadding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
    codeblockDecoration: BoxDecoration(
      color: scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.5)),
    ),

    // —— 表格 ——
    tableHead: body.copyWith(fontWeight: FontWeight.w700),
    tableBody: body.copyWith(height: 1.5, fontSize: 14),
    tablePadding: const EdgeInsets.symmetric(vertical: 12),
    tableCellsPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    tableBorder: TableBorder.all(
      color: scheme.outlineVariant,
      width: 1,
    ),
    tableCellsDecoration: BoxDecoration(
      color: scheme.surface,
    ),

    // —— 分割线 ——
    horizontalRuleDecoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          width: 1,
          color: scheme.outlineVariant.withValues(alpha: 0.8),
        ),
      ),
    ),
  );
}
