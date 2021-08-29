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
import 'package:mobile_app/src/screens/recipe_feed_screen.dart';
import 'package:mobile_app/src/services/post_service.dart';
import 'package:mobile_app/src/widgets/custom_button.dart';
import 'package:mobile_app/src/widgets/icon_button_custom.dart';
import 'package:mobile_app/src/widgets/logo.dart';
import 'package:mobile_app/src/widgets/recipe_feed/recipe_card_mobile.dart';
import 'package:mobile_app/src/widgets/recipe_feed/recipe_card_tablet.dart';
import 'package:mobile_app/src/widgets/top_bar_tablet.dart';

import 'package:mockito/mockito.dart';
import '../../cloud_firestore_mock.dart';

class MockPostServices extends Mock implements PostServices {}

void main() {
  late PostBloc postBloc;
  late MockPostServices mockPostServices;
  setUpAll(() async {
    setupCloudFirestoreMocks();
    Firebase.initializeApp();
  });
  setUp(() {
    mockPostServices = MockPostServices();
    postBloc = PostBloc(postServices: mockPostServices);
    HttpOverrides.global = null;
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
    PageController controller = PageController();
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
      postBloc.emit(PostLoadSuccess(posts: [mockPost]));
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
      Device.width = 768;
      Device.height = 1024;
      Device.devicePixelRatio = 1;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(tabletWidget);

      expect(find.byType(PreferredSize), findsOneWidget);
    });
    testWidgets('should tap CustomButton', (WidgetTester tester) async {
      await tester.pumpWidget(tabletWidget);

      await tester.tap(find.byType(CustomButton));
      expect(find.byType(CustomButton), findsOneWidget);
    });
    testWidgets('should tap Topbartablet', (WidgetTester tester) async {
      await tester.pumpWidget(tabletWidget);

      expect(find.byType(TopBarTablet), findsOneWidget);
    });
    testWidgets('renders RecipeCardTablet when state is PostLoadSuccess',
        (WidgetTester tester) async {
      await tester.pumpWidget(tabletWidget);
      postBloc.emit(PostLoadSuccess());
      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);
    });
    testWidgets('Should test the scroll', (WidgetTester tester) async {
      await tester.pumpWidget(tabletWidget);
      final gesture = await tester
          .startGesture(Offset(0, 300)); //Position of the scrollview
      await gesture.moveBy(Offset(0, -300)); //How much to scroll by
      await tester.pump();
    });
    testWidgets('renders text fail', (WidgetTester tester) async {
      await tester.pumpWidget(tabletWidget);
      postBloc.emit(PostLoadFailure(errorMessage: RecipeFeedText.loadingFail));
      await tester.pump();
      expect(find.text(RecipeFeedText.loadingFail), findsOneWidget);
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
