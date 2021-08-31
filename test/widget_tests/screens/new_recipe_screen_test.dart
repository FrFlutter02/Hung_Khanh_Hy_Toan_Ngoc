import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_bloc.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_state.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/models/category.dart';
import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/screens/new_recipe_screen.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/new_recipe/bottom_sheet_pick_image.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_additional_info.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_gallery.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_how_to_cook.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_ingredients.dart';
import 'package:mocktail/mocktail.dart';

import '../../cloud_firestore_mock.dart';

class FakeRoute extends Fake implements Route {}

class MockUser extends Mock implements User {
  @override
  String? get email {
    return 'email';
  }
}

class MockUserServices extends Mock implements UserServices {
  @override
  Future<User> getUser() async {
    return MockUser();
  }
}

class MockNavigationObserver extends Mock implements NavigatorObserver {}

void main() {
  final fakeFile = File('fakeFilePath');
  final _fakeCategories = [
    CategoryModel(categoryName: 'categoryName 1', totalRecipes: 1),
    CategoryModel(categoryName: 'categoryName 2', totalRecipes: 2),
  ];
  final mockObserver = MockNavigationObserver();
  final _newRecipeBloc = NewRecipeBloc();
  final _widget = MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(userServices: MockUserServices()),
        ),
        BlocProvider(
          create: (context) => _newRecipeBloc,
        )
      ],
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          routes: {
            "/": (context) => NewRecipeScreen(),
            "/loginScreen": (context) => LoginScreen(),
          },
          navigatorObservers: [mockObserver],
        ),
      ));

  setUpAll(() async {
    setupCloudFirestoreMocks();
    Firebase.initializeApp();
    registerFallbackValue(FakeRoute());
  });

  testWidgets(
      'Should render itemNewGalleryFinder, itemNewIngredientFinder, itemHowToCookFinder, itemNewAdditionalFinder',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);

    final itemNewGalleryFinder = find.byType(ItemNewGallery);
    final itemNewIngredientFinder = find.byType(ItemNewIngredients);
    final itemHowToCookFinder = find.byType(ItemNewHowToCook);
    final itemNewAdditionalFinder = find.byType(ItemNewAdditionalInfo);

    expect(itemNewGalleryFinder, findsOneWidget);
    expect(itemNewIngredientFinder, findsOneWidget);
    expect(itemHowToCookFinder, findsOneWidget);
    expect(itemNewAdditionalFinder, findsOneWidget);
  });
  testWidgets('Should render correct leading text,icon Back to my recipes',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);

    final textFinder = find.text(NewRecipeText.leadingText);
    final iconFinder = find.byIcon(Icons.chevron_left_outlined);

    expect(textFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
  });
  testWidgets('Should render correct title text,icon name recipes',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final textTitleFinder = find.text(NewRecipeText.titleText);

    expect(textTitleFinder, findsOneWidget);
  });
  testWidgets('Should render correct main icon name recipes',
      (WidgetTester tester) async {
    File imageMain = File("");

    await tester.pumpWidget(_widget);

    final containerFiner =
        find.descendant(of: find.byType(Row), matching: find.byType(Container));
    final elevatedButtonFinder = find.descendant(
        of: containerFiner, matching: find.byType(ElevatedButton));
    expect(elevatedButtonFinder, findsOneWidget);
    final _image =
        find.descendant(of: elevatedButtonFinder, matching: find.byType(Image));
    final _imageFinder = tester.widget<Image>(_image).image as AssetImage;

    imageMain.path == ""
        ? expect(_imageFinder.assetName, "assets/images/icons/plus_icon.png")
        : expect(_imageFinder, findsNothing);
  });
  testWidgets('Should render correct label text field name recipes',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final textTitleFinder = find.text(NewRecipeText.labelRecipeNameText);
    final textFieldFinder = find.byType(TextField);
    expect(textTitleFinder, findsOneWidget);
    expect(textFieldFinder, findsWidgets);
  });
  testWidgets('Should render a drop down button', (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final Type dropdownButtonType = DropdownButton<String>(
      onChanged: (_) {},
      items: const <DropdownMenuItem<String>>[],
    ).runtimeType;
    final dropdownButton = find.byType(dropdownButtonType);
    expect(dropdownButton, findsOneWidget);
  });
  testWidgets('Should render a outLineButton', (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final outLineButtonFinder = find.byType(OutlinedButton);
    final textFinder = find.descendant(
        of: outLineButtonFinder,
        matching: find.text(NewRecipeText.saveRecipeText));
    expect(outLineButtonFinder, findsWidgets);
    expect(textFinder, findsWidgets);
  });
  testWidgets('Should render a CircularProgressIndicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    _newRecipeBloc.emit(NewRecipeLoading());
    await tester.pump();
    final iii = find.descendant(
        of: find.byType(Center),
        matching: find.byType(CircularProgressIndicator));
    expect(iii, findsOneWidget);
  });

  // testWidgets(
  //     'Should have categories when emitting [NewRecipeCategoriesLoadSuccess]',
  //     (WidgetTester tester) async {
  //   await tester.pumpWidget(_widget);
  //   final NewRecipeScreenState _newRecipeScreenState =
  //       tester.state(find.byType(NewRecipeScreen));
  //   _newRecipeBloc
  //       .emit(NewRecipeCategoriesLoadSuccess(categories: _fakeCategories));
  //   await tester.pump();
  //   expect(_newRecipeScreenState.categories, _fakeCategories);
  //   expect(find.byKey(Key('categoryDropdown')), findsOneWidget);
  // });

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
      'Should render BottomSheetPickImage when pressing on mainImage button',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final _mainImageFinder = find.descendant(
        of: find.byType(Row), matching: find.byType(ElevatedButton));
    await tester.tap(_mainImageFinder);
    await tester.pumpAndSettle();
    expect(find.byType(BottomSheetPickImage), findsOneWidget);
  });

  testWidgets('Should render ClipRRect when mainImage path is not empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    _newRecipeBloc.emit(NewRecipeAddImageMainSuccess(fakeFile));
    await tester.pump();
    expect(find.byType(ClipRRect), findsOneWidget);
  });

  testWidgets(
      'Should render add_outlined icon and text field when addCategory is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final NewRecipeScreenState _newRecipeScreenState =
        tester.state(find.byType(NewRecipeScreen));
    // _newRecipeScreenState.addCategory = true;
    // final _addCategoryInkWellFinder = find.descendant(
    //     of: find.byType(Column), matching: find.byType(InkWell));

    await tester.pump();
    expect(find.byKey(Key('addCategoryText')), findsOneWidget);
  });

  testWidgets(
      'mainImage should not be empty file when [NewRecipeAddImageMainSuccess] is emitted',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final NewRecipeScreenState _newRecipeScreenState =
        tester.state(find.byType(NewRecipeScreen));
    _newRecipeBloc.emit(NewRecipeAddImageMainSuccess(fakeFile));
    await tester.pump();
    expect(_newRecipeScreenState.imageMain, fakeFile);
  });

  testWidgets(
      'Should render a snackbar with success message when [NewRecipeSaveRecipeSuccess] is emitted',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    _newRecipeBloc.emit(NewRecipeSaveRecipeSuccess());
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(NewRecipeText.saveNewRecipeSuccessText), findsOneWidget);
  });

  testWidgets(
      'Should render a snackbar with error message when [NewRecipeValidateFailure] is emitted',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    _newRecipeBloc
        .emit(NewRecipeValidateFailure(howToCookErrorMessage: 'howToCook'));
    await tester.pump();
    final snackBarFinder = find.byType(SnackBar);
    expect(snackBarFinder, findsOneWidget);
    expect((tester.widget<SnackBar>(snackBarFinder).content as Text).data,
        'howToCook should not be empty');
  });
}
