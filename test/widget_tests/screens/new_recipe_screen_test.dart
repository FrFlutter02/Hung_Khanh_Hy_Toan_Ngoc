import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/screens/new_recipe_screen.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_additional_info.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_gallery.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_how_to_cook.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_ingredients.dart';
import 'package:mocktail/mocktail.dart';

import '../../cloud_firestore_mock.dart';

class FakeRoute extends Fake implements Route {}

class MockUserServices extends Mock implements UserServices {}

class MockNavigationObserver extends Mock implements NavigatorObserver {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    Firebase.initializeApp();
    registerFallbackValue(FakeRoute());
  });
  final mockObserver = MockNavigationObserver();
  final mockUserServices = MockUserServices();
  final _newRecipeBloc = NewRecipeBloc(userServices: mockUserServices);
  final _widget = BlocProvider(
      create: (_) => _newRecipeBloc,
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          routes: {
            "/": (context) => NewRecipeScreen(),
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
    await tester.pumpWidget(_widget);
    final _image =
        find.descendant(of: find.byType(InkWell), matching: find.byType(Image));
    final _imageFinder = tester.widget<Image>(_image).image as AssetImage;
    expect(_imageFinder, findsWidgets);
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

    final dropDownButtonFinder = find.byType(DropdownButton);

    expect(dropDownButtonFinder, findsWidgets);
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
}
