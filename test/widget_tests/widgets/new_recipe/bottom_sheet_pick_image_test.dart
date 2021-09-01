import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'package:mobile_app/src/screens/new_recipe_screen.dart';
import 'package:mobile_app/src/services/new_recipe_services.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/new_recipe/bottom_sheet_pick_image.dart';
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
  setUp(() async {});
  final _newRecipeBloc = NewRecipeBloc(newRecipeServices: newRecipeServices);
  final _widget = BlocProvider(
      create: (_) => _newRecipeBloc,
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          home: Scaffold(
              body: BottomSheetPickImage(
            typeImage: ImageType.imageForGallery,
          )),
        ),
      ));
  testWidgets('Should render correct texts', (tester) async {
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    await tester.pumpWidget(_widget);
    expect(find.text('Camera'), findsOneWidget);
    expect(find.text("Choose option"), findsOneWidget);
    expect(find.text("Gallery"), findsOneWidget);
  });
  testWidgets('Should render InkWell Camera', (tester) async {
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    await tester.pumpWidget(_widget);
    expect(find.byType(InkWell).first, findsOneWidget);
  });
  testWidgets('Should render InkWell Gallery', (tester) async {
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    await tester.pumpWidget(_widget);
    expect(find.byType(InkWell).last, findsOneWidget);
  });
}
