import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_docs_demo/generated/demo_registry.g.dart';
import 'package:flutter_docs_demo/screens/demo_screen.dart';
import 'package:flutter_docs_demo/screens/home_screen.dart';
import 'package:flutter_docs_demo/screens/module_screen.dart';
import 'package:flutter_docs_demo/screens/section_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/section/:sectionId',
      builder: (context, state) {
        final sectionId = state.pathParameters['sectionId']!;
        return SectionScreen(sectionFolder: sectionId);
      },
    ),
    GoRoute(
      path: '/section/:sectionId/module/:moduleId',
      builder: (context, state) {
        return ModuleScreen(
          sectionFolder: state.pathParameters['sectionId']!,
          moduleFolder: state.pathParameters['moduleId']!,
        );
      },
    ),
    GoRoute(
      path: '/demo/:demoId',
      builder: (context, state) {
        final demoId = state.pathParameters['demoId']!;
        final entry = kDemoById[demoId];
        if (entry == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('未找到示例')),
            body: Center(child: Text('Demo not found: $demoId')),
          );
        }
        return DemoScreen(entry: entry);
      },
    ),
  ],
);
