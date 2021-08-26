import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_app/src/blocs/post_bloc/post_bloc.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/screens/recipe_feed_screen.dart';
import 'package:mobile_app/src/services/post_service.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/custom_button.dart';
import 'package:mobile_app/src/widgets/icon_button_custom.dart';
import 'package:mobile_app/src/widgets/logo.dart';

import 'package:mockito/mockito.dart';
import '../../cloud_firestore_mock.dart';

class MockPostServices extends Mock implements PostServices {}

class MockUserServices extends Mock implements UserServices {}

void main() {
  late PostBloc postBloc;
  late MockPostServices mockPostServices;
  late MockUserServices mockUserServices;
  setUpAll(() async {
    setupCloudFirestoreMocks();
    Firebase.initializeApp();
  });
  setUp(() {
    mockPostServices = MockPostServices();
    postBloc = PostBloc(postServices: mockPostServices);
  });

  final mobileWidget = ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => MaterialApp(
            home: BlocProvider(
              create: (context) => postBloc,
              child: Scaffold(
                body: RecipeFeedScreen(),
              ),
            ),
          ));

  final tabletWidget = ScreenUtilInit(
      designSize: Size(768, 1024),
      builder: () => MaterialApp(
              home: BlocProvider(
            create: (context) => postBloc,
            child: Scaffold(
              body: RecipeFeedScreen(),
            ),
          )));
  group('mobile test', () {
    testWidgets('Should render Recipe Feed Screen Mobile widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(mobileWidget);
      final logoFinder = find.byType(Logo);
      expect(logoFinder, findsOneWidget);

      final buttonFinder = find.byType(IconButtonCustom);
      expect(buttonFinder, findsNWidgets(2));
      // expect(
      //     find.descendant(
      //         of: find.byType(PageView),
      //         matching: find.byType(RecipeCardMobile)),
      //     findsOneWidget);

      expect(find.byType(PreferredSize), findsOneWidget);
    });
  });

  group('tablet test', () {
    testWidgets('Should render CustomButton on tablet screen',
        (WidgetTester tester) async {
      // Device.width = 768;
      // Device.height = 1024;
      // Device.devicePixelRatio = 1;
      // addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(tabletWidget);

      final textFinder =
          find.text('286 ${RecipeFeedText.ofYourFollowersAreOnline}');
      expect(textFinder, findsOneWidget);

      expect(find.byType(PreferredSize), findsOneWidget);

      await tester.pump();
      expect(
          find.descendant(
              of: find.byType(Row), matching: find.byType(CustomButton)),
          findsOneWidget);
    });
  });
}
