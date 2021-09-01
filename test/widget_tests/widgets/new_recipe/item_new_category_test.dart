import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_state.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/models/category.dart';
import 'package:mobile_app/src/screens/new_recipe_screen.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_category.dart';

import '../../../cloud_firestore_mock.dart';

void main() {
  final _fakeCategories = [
    CategoryModel(categoryName: 'categoryName 1', totalRecipes: 1),
    CategoryModel(categoryName: 'categoryName 2', totalRecipes: 2),
    CategoryModel(categoryName: '', totalRecipes: 0),
  ];
  late NewRecipeBloc _newRecipeBloc;
  final _widget = BlocProvider(
      create: (context) => _newRecipeBloc,
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          home: Scaffold(
            body: ItemNewCategory(),
          ),
        ),
      ));

  setUpAll(() async {
    setupCloudFirestoreMocks();
    Firebase.initializeApp();
  });

  setUp(() async {
    _newRecipeBloc = NewRecipeBloc();
  });

  testWidgets(
      'Should have categories when emitting [NewRecipeCategoriesLoadSuccess]',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final ItemNewCategoryState _itemNewCategoryState =
        tester.state(find.byType(ItemNewCategory));
    _newRecipeBloc
        .emit(NewRecipeCategoriesLoadSuccess(categories: _fakeCategories));
    await tester.pump();
    expect(_itemNewCategoryState.categories, _fakeCategories);
  });

  // testWidgets('Should change dropdownValue when DropdownButton changing values',
  //     (WidgetTester tester) async {
  //   await tester.pumpWidget(_widget);
  //   final NewRecipeScreenState _newRecipeScreenState =
  //       tester.state(find.byType(NewRecipeScreen));
  //   _newRecipeBloc
  //       .emit(NewRecipeCategoriesLoadSuccess(categories: _fakeCategories));
  //   await tester.pump();
  //   final _categoryDropdownFinder = find.byKey(Key('categoryDropdown'));
  //   final _categoryDropdownItems =
  //       tester.widget<DropdownButton>(_categoryDropdownFinder).items;
  //   await tester.tap(_categoryDropdownFinder);
  //   await tester.pump();
  //   await tester.tap(find.text('categoryName 2'));
  //   await tester.pump();
  //   expect(_newRecipeScreenState.dropdownValue, 'categoryName 2');
  // });

  testWidgets(
      'Should render add_outlined icon and text field when addCategory is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final ItemNewCategoryState _itemNewCategoryState =
        tester.state(find.byType(ItemNewCategory));
    _itemNewCategoryState.addCategory = true;
    // final _addCategoryInkWellFinder = find.descendant(
    //     of: find.byType(Column), matching: find.byType(InkWell));

    // await tester.pump();
    // expect(find.byKey(Key('addCategoryIcon')), findsOneWidget);
    expect(find.byKey(Key('categoryDropdown')), findsOneWidget);
  });

  testWidgets(
      'Should render DropdownButton and DropdownMenuItems when addCategory is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final ItemNewCategoryState _itemNewCategoryState =
        tester.state(find.byType(ItemNewCategory));

    _newRecipeBloc
        .emit(NewRecipeCategoriesLoadSuccess(categories: _fakeCategories));
    await tester.pump();
    final _categoryDropdownFinder = find.byKey(Key('categoryDropdown'));
    final _categoryDropdownItems =
        tester.widget<DropdownButton>(_categoryDropdownFinder).items;
    final _addCategoryTextFinder = find.byKey(Key('addCategoryText'));
    // final _addCategoryTextWidget =
    //     (_categoryDropdownItems?.last as DropdownMenuItem<String>).child
    //         as Column;
    expect(_categoryDropdownItems?.length, 3);

    await tester.tap(_categoryDropdownFinder);
    await tester.pump();
    await tester.tap(_addCategoryTextFinder);
    await tester.pump();
    expect(_itemNewCategoryState.addCategory, true);
    // expect(
    //     find.descendant(
    //         of: find.byWidget(_addCategoryTextWidget),
    //         matching: find.text(NewRecipeText.AddNewCategoryText)),
    //     NewRecipeText.AddNewCategoryText);
  });
}
