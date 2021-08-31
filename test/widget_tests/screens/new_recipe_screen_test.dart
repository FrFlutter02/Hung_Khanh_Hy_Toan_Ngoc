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
import 'package:mobile_app/src/services/user_services.dart';
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
  setUpAll(() async {
    setupCloudFirestoreMocks();
    Firebase.initializeApp();
    registerFallbackValue(FakeRoute());
  });
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
}
