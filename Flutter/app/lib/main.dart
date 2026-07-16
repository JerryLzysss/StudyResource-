import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_docs_demo/router/app_router.dart';

void main() {
  runApp(const FlutterDocsDemoApp());
}

/// 仅使用 pubspec 声明的本地字体（AppNotoSansSC / AppRoboto）。
/// 族名刻意不叫「Noto Sans SC」「Roboto」，避免 Flutter Web 再去 fonts.gstatic.com 下载。
ThemeData _buildTheme() {
  const fontFamily = 'AppNotoSansSC';
  const fontFallback = <String>[
    'AppRoboto',
    'Segoe UI Emoji',
    'Segoe UI Symbol',
    'Apple Color Emoji',
  ];

  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFallback,
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(
      fontFamily: fontFamily,
      fontFamilyFallback: fontFallback,
    ),
    primaryTextTheme: base.primaryTextTheme.apply(
      fontFamily: fontFamily,
      fontFamilyFallback: fontFallback,
    ),
  );
}

class FlutterDocsDemoApp extends StatelessWidget {
  const FlutterDocsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FlutterDocs Demo',
      theme: _buildTheme(),
      locale: const Locale('zh', 'CN'),
      supportedLocales: const [
        Locale('zh', 'CN'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: appRouter,
    );
  }
}
