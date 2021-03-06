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
import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/screens/new_recipe_screen.dart';
import 'package:mobile_app/src/services/create_recipe_services.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/new_recipe/bottom_sheet_pick_image.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_additional_info.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_category.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_gallery.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_how_to_cook.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_ingredients.dart';
import 'package:mocktail/mocktail.dart';

import '../../cloud_firestore_mock.dart';

class MockUser extends Mock implements User {
  @override
  String? get email {
    return 'email';
  }
}

class MockUserServices extends Mock implements UserServices {
  @override
  Future<User> getCurrentUser() async {
    return MockUser();
  }
}

class MockNavigationObserver extends Mock implements NavigatorObserver {}

class MockNewRecipeServices extends Mock implements CreateRecipeServices {}

void main() {
  late MockNewRecipeServices mockNewRecipeServices;
  final fakeFile = File('fakeFilePath');
  final mockObserver = MockNavigationObserver();
  late LoginBloc _logicBloc;
  late NewRecipeBloc _newRecipeBloc;
  final _widget = MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _logicBloc,
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
  });

  setUp(() async {
    mockNewRecipeServices = MockNewRecipeServices();
    _logicBloc = LoginBloc(userServices: MockUserServices());
    _newRecipeBloc = NewRecipeBloc(newRecipeServices: mockNewRecipeServices);
  });

  testWidgets(
      'Should render itemNewGalleryFinder, itemNewIngredientFinder, itemHowToCookFinder, itemNewAdditionalFinder, itemNewCategoryFinder',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);

    final itemNewGalleryFinder = find.byType(ItemNewGallery);
    final itemNewIngredientFinder = find.byType(ItemNewIngredients);
    final itemHowToCookFinder = find.byType(ItemNewHowToCook);
    final itemNewAdditionalFinder = find.byType(ItemNewAdditionalInfo);
    final itemNewCategoryFinder = find.byType(ItemNewCategory);

    expect(itemNewGalleryFinder, findsOneWidget);
    expect(itemNewIngredientFinder, findsOneWidget);
    expect(itemHowToCookFinder, findsOneWidget);
    expect(itemNewAdditionalFinder, findsOneWidget);
    expect(itemNewCategoryFinder, findsOneWidget);
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

  testWidgets('Should render ClipRRect when mainImage path is not empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    _newRecipeBloc.emit(NewRecipeAddImageMainSuccess(fakeFile));
    await tester.pump();
    expect(find.byType(ClipRRect), findsOneWidget);
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
      'Should render a snackbar with success message when [NewRecipeSaveRecipeFailure] is emitted',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    _newRecipeBloc.emit(NewRecipeSaveRecipeFailure());
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(NewRecipeText.saveNewRecipeFailureText), findsOneWidget);
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
}
