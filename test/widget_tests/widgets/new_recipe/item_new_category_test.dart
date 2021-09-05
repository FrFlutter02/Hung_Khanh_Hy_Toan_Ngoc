import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_state.dart';
import 'package:mobile_app/src/models/category.dart';
import 'package:mobile_app/src/services/create_recipe_services.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_category.dart';

import '../../../cloud_firestore_mock.dart';

CreateRecipeServices createRecipeServices = CreateRecipeServices();
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
    _newRecipeBloc = NewRecipeBloc(newRecipeServices: createRecipeServices);
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

  testWidgets(
      'Should change dropdownValue when emitting [NewRecipeAddCategorySuccess]',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final ItemNewCategoryState _itemNewCategoryState =
        tester.state(find.byType(ItemNewCategory));
    _newRecipeBloc.emit(NewRecipeAddCategorySuccess('fakeCategory'));
    await tester.pump();
    expect(_itemNewCategoryState.dropdownValue, 'fakeCategory');
  });

  testWidgets(
      'Should update addCategory to true when clicking on addCategoryText',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    _newRecipeBloc
        .emit(NewRecipeCategoriesLoadSuccess(categories: _fakeCategories));
    await tester.pump();
    final ItemNewCategoryState _itemNewCategoryState =
        tester.state(find.byType(ItemNewCategory));
    final _categoryDropdownFinder = find.byKey(Key('categoryDropdown'));
    final _addCategoryTextFinder = find.byKey(Key('addCategoryText'));
    await tester.tap(_categoryDropdownFinder);
    await tester.pump();
    await tester.tap(_addCategoryTextFinder.last);
    await tester.pump();
    expect(_itemNewCategoryState.addCategory, true);
  });

  testWidgets(
      'Should render add_outlined icon and text field when addCategory is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final ItemNewCategoryState _itemNewCategoryState =
        tester.state(find.byType(ItemNewCategory));
    _newRecipeBloc
        .emit(NewRecipeCategoriesLoadSuccess(categories: _fakeCategories));
    await tester.pump();
    final _categoryDropdownFinder = find.byKey(Key('categoryDropdown'));
    final _addCategoryTextFinder = find.byKey(Key('addCategoryText'));
    await tester.tap(_categoryDropdownFinder);
    await tester.pump();
    await tester.tap(_addCategoryTextFinder.last);
    await tester.pump();

    _itemNewCategoryState.categoryController.text = 'new category';
    await tester.pump();
    final _addCategoryIconFinder = find.byKey(Key('addCategoryIcon'));
    await tester.tap(_addCategoryIconFinder);
    await tester.pump();

    expect(_itemNewCategoryState.categories, [
      CategoryModel(categoryName: 'categoryName 1', totalRecipes: 1),
      CategoryModel(categoryName: 'categoryName 2', totalRecipes: 2),
      CategoryModel(categoryName: 'new category', totalRecipes: 0),
      CategoryModel(categoryName: '', totalRecipes: 0),
    ]);
    expect(_itemNewCategoryState.categoryController.text, isEmpty);
    expect(_itemNewCategoryState.addCategory, false);
  });

  testWidgets(
      'Should render DropdownButton and DropdownMenuItems when addCategory is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    _newRecipeBloc
        .emit(NewRecipeCategoriesLoadSuccess(categories: _fakeCategories));
    await tester.pump();
    final _categoryDropdownFinder = find.byKey(Key('categoryDropdown'));
    final _categoryDropdownItems =
        tester.widget<DropdownButton>(_categoryDropdownFinder).items;
    expect(_categoryDropdownItems?.length, 3);
  });
}
