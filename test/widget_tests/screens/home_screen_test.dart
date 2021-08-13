import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';

import 'package:mobile_app/src/screens/home_screen.dart';
import 'package:mobile_app/src/screens/recipe_screen.dart';
import 'package:mobile_app/src/screens/search_screen.dart';
import 'package:mobile_app/src/screens/user_profile_screen.dart';

import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

void main() {
  setUp(() => {registerFallbackValue(MyFakeType())});
  final _widget = BlocProvider(
    create: (_) => ForgotPasswordBloc(),
    child: MaterialApp(home: HomeScreen()),
  );

  testWidgets('Should render bottom navigation bar', (tester) async {
    await tester.pumpWidget(_widget);
    final bottomNavigationBarFinder = find.byType(BottomNavigationBar);
    expect(bottomNavigationBarFinder, findsOneWidget);
  });
  testWidgets('Should render Recipe screen first', (tester) async {
    await tester.pumpWidget(_widget);
    final _screenFinder = find.descendant(
        of: find.byType(Center), matching: find.byType(RecipeScreen));
    print(_screenFinder);
    expect(_screenFinder, findsOneWidget);
  });
  testWidgets('Should render Search logo , Carosel logo and User profile logo',
      (tester) async {
    final AssetImage imageSearch = AssetImage(
      'assets/images/search_icon.jpg',
    );
    final AssetImage imageCarosel = AssetImage(
      'assets/images/carosel_icon.jpg',
    );
    final AssetImage imageUserProfile = AssetImage(
      'assets/images/user_profile_icon.jpg',
    );
    await tester.pumpWidget(_widget);
    final bottomNavigationBarFinder = find.byType(BottomNavigationBar);

    final _imageFinder = find.descendant(
        of: bottomNavigationBarFinder, matching: find.byType(Image));

    final List<Image> _listImage =
        tester.widgetList<Image>(_imageFinder).toList();

    expect(_listImage[0].image, imageSearch);
    expect(_listImage[1].image, imageCarosel);
    expect(_listImage[2].image, imageUserProfile);
  });

  testWidgets(
      'Should render icon have correct color AppColor.green and SearchScreen  when tap the Search icon',
      (tester) async {
    await tester.pumpWidget(_widget);
    await tester.tap(find.text('Search'));
    await tester.pump();
    final bottomNavigationBarFinder = find.byType(BottomNavigationBar);

    final _imageFinder = find.descendant(
        of: bottomNavigationBarFinder, matching: find.byType(Image));
    final List<Image> _listImage =
        tester.widgetList<Image>(_imageFinder).toList();
    final _screenFinder = find.descendant(
        of: find.byType(Center), matching: find.byType(SearchScreen));
    print(_screenFinder);
    expect(_screenFinder, findsOneWidget);
    expect(_listImage[0].color, AppColor.green);
    expect(_listImage[1].color, AppColor.iconGrey);
    expect(_listImage[2].color, AppColor.iconGrey);
  });
  testWidgets(
      'Should render icon have correct color AppColor.green and SearchScreen when tap the Recipe icon',
      (tester) async {
    await tester.pumpWidget(_widget);
    await tester.tap(find.text('Recipe'));
    await tester.pump();
    final bottomNavigationBarFinder = find.byType(BottomNavigationBar);
    final _imageFinder = find.descendant(
        of: bottomNavigationBarFinder, matching: find.byType(Image));
    final List<Image> _listImage =
        tester.widgetList<Image>(_imageFinder).toList();
    final _screenFinder = find.descendant(
        of: find.byType(Center), matching: find.byType(RecipeScreen));
    print(_screenFinder);
    expect(_screenFinder, findsOneWidget);
    expect(_listImage[0].color, AppColor.iconGrey);
    expect(_listImage[1].color, AppColor.green);
    expect(_listImage[2].color, AppColor.iconGrey);
  });
  testWidgets(
      'Should render icon have correct color AppColor.green and SearchScreen when tap the User profile icon',
      (tester) async {
    await tester.pumpWidget(_widget);
    await tester.tap(find.text('User profile'));
    await tester.pump();
    final bottomNavigationBarFinder = find.byType(BottomNavigationBar);

    final _imageFinder = find.descendant(
        of: bottomNavigationBarFinder, matching: find.byType(Image));

    final List<Image> _listImage =
        tester.widgetList<Image>(_imageFinder).toList();
    final _screenFinder = find.descendant(
        of: find.byType(Center), matching: find.byType(UserProfileScreen));
    print(_screenFinder);
    expect(_screenFinder, findsOneWidget);
    expect(_listImage[0].color, AppColor.iconGrey);
    expect(_listImage[1].color, AppColor.iconGrey);
    expect(_listImage[2].color, AppColor.green);
  });
}
