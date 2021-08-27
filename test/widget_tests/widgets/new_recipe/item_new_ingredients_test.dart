import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_state.dart';
import 'package:mobile_app/src/models/ingredients_model.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/new_recipe/bottom_sheet_pick_image.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_ingredients.dart';
import 'package:mockito/mockito.dart';

import '../../../cloud_firestore_mock.dart';

class MockUserServices extends Mock implements UserServices {}

void main() {
  late NewRecipeBloc _newRecipeBloc;
  final _widget = BlocProvider(
      create: (_) => _newRecipeBloc,
      child: ScreenUtilInit(
        designSize: Size(375, 800),
        builder: () => MaterialApp(
          home: Scaffold(body: ItemNewIngredients()),
        ),
      ));

  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  setUp(() {
    _newRecipeBloc = NewRecipeBloc();
  });

  testWidgets(
      "Should add one ingredient into ingredientList when [NewRecipeAddIngredientSuccess] is called",
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final StatefulElement _itemNewIngredientsElement =
        tester.element(find.byType(ItemNewIngredients));
    final _itemNewIngredientsState =
        _itemNewIngredientsElement.state as ItemNewIngredientsState;
    final fakeIngredient = IngredientModel(
        id: 'id', ingredient: 'ingredient', image: File('hehe'));

    _newRecipeBloc.emit(NewRecipeAddIngredientSuccess(fakeIngredient));
    await tester.pump();
    expect(_itemNewIngredientsState.ingredientList, [fakeIngredient]);
  });

  testWidgets(
      "Should add one image into imageIngredient when [NewRecipeAddImageIngredientSuccess] is called",
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final StatefulElement _itemNewIngredientsElement =
        tester.element(find.byType(ItemNewIngredients));
    final _itemNewIngredientsState =
        _itemNewIngredientsElement.state as ItemNewIngredientsState;
    final fakeImageFile = File('file_path');

    _newRecipeBloc.emit(NewRecipeAddImageIngredientSuccess(fakeImageFile));
    await tester.pump();
    expect(_itemNewIngredientsState.imageIngredient, fakeImageFile);
  });

  testWidgets(
      "Test add ingredient InkWell onTap() when addIngredientController.text is empty",
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final StatefulElement _itemNewIngredientsElement =
        tester.element(find.byType(ItemNewIngredients));
    final _itemNewIngredientsState =
        _itemNewIngredientsElement.state as ItemNewIngredientsState;
    final firstInkWell = find.descendant(
        of: find.byType(Padding), matching: find.byType(InkWell).first);

    await tester.tap(firstInkWell);
    await tester.pumpAndSettle();
    expect(_itemNewIngredientsState.addIngredientController.text, isEmpty);
    expect(_itemNewIngredientsState.imageIngredient.path, '');
  });

  testWidgets("Test image InkWell onTap() ", (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final secondInkWell = find.descendant(
        of: find.byType(Padding), matching: find.byType(InkWell).last);

    await tester.tap(secondInkWell);
    await tester.pumpAndSettle();
    expect(find.byType(BottomSheetPickImage), findsOneWidget);
  });
}
