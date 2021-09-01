import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_state.dart';
import 'package:mobile_app/src/models/how_to_cook_model.dart';
import 'package:mobile_app/src/services/new_recipe_services.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_how_to_cook.dart';
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

  late NewRecipeBloc _newRecipeBloc;
  setUp(() {
    _newRecipeBloc = NewRecipeBloc(newRecipeServices: newRecipeServices);
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
  testWidgets("Should render from step text", (WidgetTester tester) async {
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
    final stepFinder = find.text("step 1");
    expect(linkFinder, findsOneWidget);
    expect(stepFinder, findsOneWidget);
  });
  testWidgets("Should render from step text and reset text field",
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final StatefulElement _itemHowToCook =
        tester.element(find.byType(ItemNewHowToCook));
    final ItemNewHowToCookState _itemHowToCookState =
        _itemHowToCook.state as ItemNewHowToCookState;
    _itemHowToCookState.addLinkController.text = "http";

    _itemHowToCookState.step = 1;
    await tester.tap(find.descendant(
        of: find.byType(InkWell), matching: find.byIcon(Icons.add_outlined)));
    await tester.pump();
    _itemHowToCookState.addStepController.text = "step 1";
    await tester.tap(find.descendant(
        of: find.byType(InkWell), matching: find.byIcon(Icons.add_outlined)));
    await tester.pump();
    final rowFinder =
        find.descendant(of: find.byType(Container), matching: find.byType(Row));
    final containerFinder =
        find.descendant(of: rowFinder, matching: find.byType(Container));
    final centerFinder =
        find.descendant(of: containerFinder, matching: find.byType(Center));

    final stepTextFinder = find.text("");
    expect(_itemHowToCookState.step, 2);
    expect(stepTextFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
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
        duration: '3 minute', id: '1', step: 1, textHowToCook: 'step 1');

    _newRecipeBloc.emit(NewRecipeAddStepHowToCookSuccess(fakeHowToCook));
    await tester.pump();
    expect(_itemHowToCookState.howToCookList, [fakeHowToCook]);
  });
  testWidgets(
      "aaShould add one how to cook into howToCookList when [NewRecipeAddIngredientSuccess] is called",
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final StatefulElement _itemHowToCook =
        tester.element(find.byType(ItemNewHowToCook));
    final ItemNewHowToCookState _itemHowToCookState =
        _itemHowToCook.state as ItemNewHowToCookState;
    _itemHowToCookState.addLink = true;
    await tester.tap(find.descendant(
        of: find.byType(InkWell), matching: find.byIcon(Icons.add_outlined)));
    await tester.pump();
    final fakeHowToCook = HowToCookModel(
        duration: '3 minute', id: '1', step: 7, textHowToCook: 'step 1');

    _newRecipeBloc.emit(NewRecipeAddStepHowToCookSuccess(fakeHowToCook));
    await tester.pumpAndSettle();
    final textStepFinder = find.text("step 1");
    final stepFinder = find.text("7");
    expect(textStepFinder, findsOneWidget);
    expect(stepFinder, findsOneWidget);
  });
}
