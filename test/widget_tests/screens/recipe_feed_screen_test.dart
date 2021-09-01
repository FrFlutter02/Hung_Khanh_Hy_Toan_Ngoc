import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_app/src/blocs/post_bloc/post_bloc.dart';

import 'package:mobile_app/src/blocs/post_bloc/post_state.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/models/post_model.dart';
import 'package:mobile_app/src/models/user_model.dart';
import 'package:mobile_app/src/screens/recipe_feed_screen.dart';
import 'package:mobile_app/src/services/post_service.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/custom_button.dart';
import 'package:mobile_app/src/widgets/icon_button_custom.dart';
import 'package:mobile_app/src/widgets/logo.dart';
import 'package:mobile_app/src/widgets/recipe_feed/recipe_card_mobile.dart';
import 'package:mobile_app/src/widgets/recipe_feed/recipe_card_tablet.dart';
import 'package:mobile_app/src/widgets/top_bar_tablet.dart';

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
    HttpOverrides.global = null;
  });
  setUp(() {
    mockPostServices = MockPostServices();
    mockUserServices = MockUserServices();
    postBloc = PostBloc(
        postServices: mockPostServices, userServices: mockUserServices);
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
      designSize: Size(748, 1024),
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

      expect(find.byType(PreferredSize), findsOneWidget);
    });
    testWidgets('renders RecipeCardMobile when state is PostLoadSuccess',
        (WidgetTester tester) async {
      await tester.pumpWidget(mobileWidget);
      final StatefulElement _recipeFeedScreenElement =
          tester.element(find.byType(RecipeFeedScreen));
      final RecipeFeedScreenState _recipeFeedScreenState =
          _recipeFeedScreenElement.state as RecipeFeedScreenState;
      final pageViewFinder = find.byType(PageView);
      final mockPost = Post(
          backgroundImage:
              "https://img.hoidap247.com/picture/question/20200718/large_1595063159202.jpg",
          comments: 1,
          likes: 1,
          name: 'hy',
          time: 111,
          recipeId: 'ádasd',
          userId: 'vip',
          description: 'hgildasgi');
      final mockUser = UserModel(
          fullName: '',
          avatar:
              'https://img.hoidap247.com/picture/question/20200718/large_1595063159202.jpg',
          email: '');
      postBloc.emit(PostLoadSuccess(posts: [mockPost], users: [mockUser]));
      await tester.pump();
      var pageController =
          (tester.widget<PageView>(pageViewFinder).onPageChanged);
      pageController!(1);
      expect(_recipeFeedScreenState.currentpage, 1);
    });

    testWidgets('renders text fail', (WidgetTester tester) async {
      await tester.pumpWidget(mobileWidget);
      postBloc.emit(PostLoadFailure(errorMessage: RecipeFeedText.loadingFail));
      await tester.pump();
      expect(find.text(RecipeFeedText.loadingFail), findsOneWidget);
    });
    testWidgets('renders loading when state is PostLoadLoading',
        (WidgetTester tester) async {
      await tester.pumpWidget(mobileWidget);
      postBloc.emit(PostLoading());
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('tablet test', () {
    testWidgets('Should render PreferredSize on tablet screen',
        (WidgetTester tester) async {
      Device.width = 748;
      Device.height = 1024;
      Device.devicePixelRatio = 1;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(tabletWidget);

      expect(find.byType(PreferredSize), findsOneWidget);
    });
    testWidgets(
        'renders RecipeCardTablet, TopBarTablet when state is PostLoadSuccess',
        (WidgetTester tester) async {
      Device.width = 700;
      Device.height = 1000;
      Device.devicePixelRatio = 1;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(tabletWidget);
      final StatefulElement _recipeFeedScreenElement =
          tester.element(find.byType(RecipeFeedScreen));
      final RecipeFeedScreenState _recipeFeedScreenState =
          _recipeFeedScreenElement.state as RecipeFeedScreenState;
      final listViewFinder = find.byType(ListView);
      final mockPost = Post(
          backgroundImage:
              "https://img.hoidap247.com/picture/question/20200718/large_1595063159202.jpg",
          comments: 1,
          likes: 1,
          name: 'hy',
          time: 111,
          recipeId: 'ádasd',
          userId: 'vip',
          description: 'hgildasgi');
      final mockUser = UserModel(
          fullName: '',
          avatar:
              'https://img.hoidap247.com/picture/question/20200718/large_1595063159202.jpg',
          email: '');
      postBloc.emit(PostLoadSuccess(posts: [mockPost], users: [mockUser]));
      await tester.pump();

      expect(find.byType(TopBarTablet), findsOneWidget);

      expect(
          find.descendant(
              of: find.byType(ListView),
              matching: find.byType(RecipeCardTablet)),
          findsOneWidget);
    });

    testWidgets('Should render CustomButton', (WidgetTester tester) async {
      await tester.pumpWidget(tabletWidget);

      await tester.tap(find.byType(CustomButton));
      expect(find.byType(CustomButton), findsOneWidget);
    });

    testWidgets('Should test the scroll', (WidgetTester tester) async {
      await tester.pumpWidget(tabletWidget);
      final gesture = await tester.startGesture(Offset(0, 300));
      await gesture.moveBy(Offset(0, -300));
      await tester.pump();
    });
    testWidgets('renders text fail', (WidgetTester tester) async {
      await tester.pumpWidget(tabletWidget);
      postBloc.emit(PostLoadFailure(errorMessage: RecipeFeedText.loadingFail));
      await tester.pump();
      expect(find.text(RecipeFeedText.loadingFail), findsWidgets);
    });
    testWidgets('renders loading when state is PostLoadLoading',
        (WidgetTester tester) async {
      await tester.pumpWidget(tabletWidget);
      postBloc.emit(PostLoading());
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
