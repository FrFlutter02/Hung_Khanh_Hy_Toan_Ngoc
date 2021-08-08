import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/widgets/logo.dart';

main() {
  final widget = MaterialApp(
    home: Scaffold(
      body: Logo(),
    ),
  );

  testWidgets('finds text logo widget', (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    final appName = find.text('scratch');
    expect(appName, findsOneWidget);
  });

  testWidgets('Should render logo icon', (tester) async {
    await tester.pumpWidget(widget);
    final logoIcon = find.byType(Logo);
    expect(logoIcon, findsOneWidget);
  });
}
