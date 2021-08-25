import 'package:duration_picker/duration_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_state.dart';
import 'package:mobile_app/src/models/how_to_cook_model.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_how_to_cook.dart';
import 'package:mocktail/mocktail.dart';

import '../../../cloud_firestore_mock.dart';

class FakeRoute extends Fake implements Route {}

class MockUserServices extends Mock implements UserServices {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  late NewRecipeBloc _newRecipeBloc;
  setUp(() {
    _newRecipeBloc = NewRecipeBloc();
  });

  final _widget = BlocProvider(
      create: (_) => _newRecipeBloc,
      child: ScreenUtilInit(
        designSize: Size(375, 800),
        builder: () => MaterialApp(
          home: Scaffold(body: ItemNewHowToCook()),
        ),
      ));

  testWidgets("Should render correct title how to cook",
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final textFinder = find.text("How to Cook");

    expect(textFinder, findsOneWidget);
  });
  testWidgets("Should render from video title", (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    await tester.enterText(find.byType(TextField), "hamburger");
    await tester.tap(find.byIcon(Icons.add_outlined));
    await tester.pump();
    final videoIcon = find.byIcon(Icons.smart_display_outlined);
    final title = find.text("hamburger");
    final clock = find.byIcon(Icons.timer_outlined);
    expect(title, findsOneWidget);
    expect(clock, findsOneWidget);
    expect(videoIcon, findsOneWidget);
  });
  testWidgets("Should render from step title", (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final StatefulElement _itemHowToCook =
        tester.element(find.byType(ItemNewHowToCook));
    final ItemNewHowToCookState _itemHowToCookState =
        _itemHowToCook.state as ItemNewHowToCookState;

    _itemHowToCookState.addLinkController.text = "http";
    _itemHowToCookState.addStepController.text = "step 1";
    await tester.tap(find.descendant(
        of: find.byType(InkWell), matching: find.byIcon(Icons.add_outlined)));
    await tester.pump();
    final linkFinder = find.text("http");

    // await tester.tap(find.descendant(
    //     of: find.byType(ElevatedButton),
    //     matching: find.byIcon(Icons.add_outlined)));
    // await tester.pumpAndSettle();
    final stepFinder = find.text("step 1");

    final videoIcon = find.byIcon(Icons.timer_outlined);
    expect(linkFinder, findsOneWidget);
    expect(stepFinder, findsOneWidget);
  });
  testWidgets(
      "Should add one how to cook into howToCookList when [NewRecipeAddIngredientSuccess] is called",
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final StatefulElement _itemHowToCook =
        tester.element(find.byType(ItemNewHowToCook));
    final ItemNewHowToCookState _itemHowToCookState =
        _itemHowToCook.state as ItemNewHowToCookState;

    await tester.tap(find.descendant(
        of: find.byType(InkWell), matching: find.byIcon(Icons.add_outlined)));
    await tester.pump();
    final fakeHowToCook = HowToCookModel(
        duration: '3 munites', id: '1', step: 1, textHowToCook: 'step 1');

    _newRecipeBloc.emit(NewRecipeAddStepHowToCookSuccess(fakeHowToCook));
    await tester.pump();
    expect(_itemHowToCookState.howToCookList, [fakeHowToCook]);
  });
}
