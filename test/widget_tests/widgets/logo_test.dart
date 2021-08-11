import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/widgets/logo.dart';

void main() {
  final widget = MaterialApp(
    home: Scaffold(
      body: Logo(),
    ),
  );

  testWidgets('Should render text logo widget', (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    final appName = find.text('scratch');
    expect(appName, findsOneWidget);
  });

  testWidgets('Should render image logo', (WidgetTester tester) async {
    final Image imageWidget = Image.asset('assets/images/logo_icon.png');
    assert(imageWidget.image is AssetImage);
    final AssetImage assetImage = imageWidget.image as AssetImage;
    expect(assetImage.keyName, 'assets/images/logo_icon.png');
  });
}
