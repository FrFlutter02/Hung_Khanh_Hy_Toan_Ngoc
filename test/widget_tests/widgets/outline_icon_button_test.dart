import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/services/post_service.dart';
import 'package:mobile_app/src/widgets/outline_icon_button.dart';
import 'package:mockito/mockito.dart';

import '../../cloud_firestore_mock.dart';

class MockPostServices extends Mock implements PostServices {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  final widget = ScreenUtilInit(
    builder: () => MaterialApp(
      home: Scaffold(
        body: OutlineIconButton(
          title: RecipeFeedText.save,
          icons: 'assets/images/icons/add.png',
          height: 10,
          width: 10,
          radius: 8,
          color: AppColor.green,
          onTap: () {},
        ),
      ),
    ),
  );

  testWidgets('Should render the outline button text',
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    expect(find.descendant(of: find.byType(Row), matching: find.byType(Text)),
        findsOneWidget);
  });
}
