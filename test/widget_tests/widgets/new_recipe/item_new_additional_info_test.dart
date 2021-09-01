import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/services/new_recipe_services.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_additional_info.dart';
import 'package:mocktail/mocktail.dart';

import '../../../cloud_firestore_mock.dart';

class FakeRoute extends Fake implements Route {}

class MockUserServices extends Mock implements UserServices {}

NewRecipeServices newRecipeServices = NewRecipeServices();

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  final _newRecipeBloc = NewRecipeBloc(newRecipeServices: newRecipeServices);
  final _widget = BlocProvider(
      create: (_) => _newRecipeBloc,
      child: ScreenUtilInit(
        designSize: Size(375, 800),
        builder: () => MaterialApp(
          home: Scaffold(body: ItemNewAdditionalInfo()),
        ),
      ));
  testWidgets("Should render correct title additional info",
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final textFinder = find.text(NewRecipeText.labelAdditionalInfoText);

    expect(textFinder, findsOneWidget);
  });
  testWidgets("Should render icon edit or icon close",
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final containerFinder = find.descendant(
        of: find.byType(InkWell), matching: find.byType(Container));
    await tester.tap(containerFinder);
    await tester.pump();
    final iconFinder = find.byIcon(Icons.close);

    expect(iconFinder, findsOneWidget);
  });
  testWidgets("Should render button add info", (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final iconFinder = find.byIcon(Icons.add_outlined);
    final textFinder = find.text(NewRecipeText.hintAdditionalInfoText);
    expect(iconFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });

  testWidgets("Should render from additional info",
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);

    final containerFinder = find.descendant(
        of: find.byType(InkWell), matching: find.byType(Container));
    await tester.tap(containerFinder);
    await tester.pump();
    final textServingTimeFinder = find.text(NewRecipeText.servingTimeText);
    final textNutritionFactFinder = find.text(NewRecipeText.nutritionFactText);
    final textTagsFinder = find.text(NewRecipeText.tagsText);
    final textFieldFinder = find.byType(TextField);
    final textButtonFinder = find.descendant(
        of: find.byType(SizedBox), matching: find.byType(TextButton));
    expect(textServingTimeFinder, findsOneWidget);
    expect(textNutritionFactFinder, findsOneWidget);
    expect(textTagsFinder, findsOneWidget);
    expect(textFieldFinder, findsWidgets);
    expect(textButtonFinder, findsWidgets);
  });
  testWidgets("Should render servingTimeText, nutritionFactFinderText, tagText",
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final StatefulElement _itemNewAdditionalInfoElement =
        tester.element(find.byType(ItemNewAdditionalInfo));
    final ItemNewAdditionalInfoState _itemNewAdditionalInfoState =
        _itemNewAdditionalInfoElement.state as ItemNewAdditionalInfoState;
    final containerFinder = find.descendant(
        of: find.byType(InkWell), matching: find.byType(Container));
    await tester.tap(containerFinder);
    await tester.pump();
    _itemNewAdditionalInfoState.addServingTimeController.text = "12mins";
    _itemNewAdditionalInfoState.addNutritionTimeController.text = "30 calo";
    final textButtonFinder = find.descendant(
        of: find.byType(SizedBox), matching: find.byType(TextButton));
    await tester.tap(textButtonFinder);
    await tester.pump();

    final textServingTimeFinder = find.text("12mins");
    final textNutritionFactFinder = find.text("30 calo");

    expect(textServingTimeFinder, findsOneWidget);
    expect(textNutritionFactFinder, findsOneWidget);
  });
  testWidgets("Should close form additional info", (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final StatefulElement _itemNewAdditionalInfoElement =
        tester.element(find.byType(ItemNewAdditionalInfo));
    final ItemNewAdditionalInfoState _itemNewAdditionalInfoState =
        _itemNewAdditionalInfoElement.state as ItemNewAdditionalInfoState;
    final containerFinder = find.descendant(
        of: find.byType(InkWell), matching: find.byType(Container));
    await tester.tap(containerFinder);
    await tester.pump();
    final inkWellFinder =
        find.descendant(of: find.byType(Row), matching: find.byType(InkWell));
    await tester.tap(inkWellFinder);
    await tester.pump();

    expect(_itemNewAdditionalInfoState.addInfo, false);
  });
}
