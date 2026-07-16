import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_docs_demo/main.dart';

void main() {
  testWidgets('App launches home screen', (tester) async {
    await tester.pumpWidget(const FlutterDocsDemoApp());
    expect(find.text('FlutterDocs 示例合集'), findsOneWidget);
  });
}
