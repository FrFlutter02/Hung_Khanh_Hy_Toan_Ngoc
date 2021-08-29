import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/post_bloc/post_bloc.dart';
import 'package:mobile_app/src/services/post_service.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/custom_notification.dart';
import 'package:mobile_app/src/widgets/icon_button_custom.dart';
import 'package:mobile_app/src/widgets/logo.dart';
import 'package:mobile_app/src/widgets/top_bar_tablet.dart';

import 'package:mockito/mockito.dart';

import '../../cloud_firestore_mock.dart';

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    Firebase.initializeApp();
  });

  final widget = ScreenUtilInit(
      designSize: Size(768, 1024),
      builder: () => MaterialApp(
            home: Scaffold(
              body: TopBarTablet(),
            ),
          ));

  testWidgets('Should render logo and icons widgets', (tester) async {
    await tester.pumpWidget(widget);

    expect(find.descendant(of: find.byType(Stack), matching: find.byType(Logo)),
        findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(Row), matching: find.byType(IconButtonCustom)),
        findsWidgets);
    expect(
        find.descendant(
            of: find.byType(Row), matching: find.byType(CustomNotification)),
        findsWidgets);
  });
}
