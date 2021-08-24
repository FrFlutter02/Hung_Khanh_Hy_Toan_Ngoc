import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_app/src/widgets/user_profile/bottom_navigation.dart';

import '../../../cloud_firestore_mock.dart';

main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  final widget =
      ScreenUtilInit(builder: () => MaterialApp(home: BottomNavigation()));

  group("bottom navigation testing", () {
    testWidgets('Should render search icon', (WidgetTester tester) async {
      final Image imageWidget = Image.asset('assets/images/icons/search.png');
      assert(imageWidget.image is AssetImage);
      final AssetImage assetImage = imageWidget.image as AssetImage;
      expect(assetImage.keyName, 'assets/images/icons/search.png');
    });
    testWidgets('Should render tab icon', (WidgetTester tester) async {
      final Image imageWidget =
          Image.asset('assets/images/user_profile_icon/nav2.png');
      assert(imageWidget.image is AssetImage);
      final AssetImage assetImage = imageWidget.image as AssetImage;
      expect(assetImage.keyName, 'assets/images/user_profile_icon/nav2.png');
    });
    testWidgets('Should render cook icon', (WidgetTester tester) async {
      final Image imageWidget =
          Image.asset('assets/images/user_profile_icon/nav3.png');
      assert(imageWidget.image is AssetImage);
      final AssetImage assetImage = imageWidget.image as AssetImage;
      expect(assetImage.keyName, 'assets/images/user_profile_icon/nav3.png');
    });
  });
}