import 'package:flutter/material.dart';

typedef DemoBuilder = Widget Function();

class DemoEntry {
  const DemoEntry({
    required this.id,
    required this.section,
    required this.sectionFolder,
    required this.module,
    required this.moduleFolder,
    required this.title,
    required this.docAsset,
    required this.builder,
  });

  final String id;
  final String section;
  final String sectionFolder;
  final String module;
  final String moduleFolder;
  final String title;
  final String docAsset;
  final DemoBuilder builder;
}
