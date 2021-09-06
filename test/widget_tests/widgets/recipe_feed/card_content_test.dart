import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/services/post_service.dart';
import 'package:mobile_app/src/widgets/icon_button_custom.dart';
import 'package:mobile_app/src/widgets/outline_icon_button.dart';
import 'package:mobile_app/src/widgets/recipe_feed/card_content.dart';
import 'package:mockito/mockito.dart';

import '../../../cloud_firestore_mock.dart';

class MockPostServices extends Mock implements PostServices {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  final widget = ScreenUtilInit(
      builder: () => MaterialApp(
            home: Scaffold(
                body: CardContent(
              title: '',
              subtitle: '',
              numberComments: 0,
              numberLikes: 0,
            )),
          ));
  testWidgets('Should render OutlineIconButton, IconButtonCustom widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    expect(find.byType(OutlineIconButton), findsOneWidget);
    expect(find.byType(IconButtonCustom), findsOneWidget);
  });
  testWidgets('Should render Text title, subtitle widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    final Text text1 = tester.firstWidget(find.byType(Text));
    expect(text1.overflow, TextOverflow.ellipsis);

    final Text text2 = tester.widget(find.descendant(
        of: find.byType(SizedBox), matching: find.byType(Text)));
    expect(text2.overflow, TextOverflow.ellipsis);
  });

  testWidgets('Should render Text likes, comments widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    expect(find.descendant(of: find.byType(Wrap), matching: find.byType(Text)),
        findsNWidgets(2));
  });

  testWidgets('Should render image logo', (WidgetTester tester) async {
    final Image imageWidget = Image.asset('assets/images/icons/dot.png');
    assert(imageWidget.image is AssetImage);
    final AssetImage assetImage = imageWidget.image as AssetImage;
    expect(assetImage.keyName, 'assets/images/icons/dot.png');
  });
}
