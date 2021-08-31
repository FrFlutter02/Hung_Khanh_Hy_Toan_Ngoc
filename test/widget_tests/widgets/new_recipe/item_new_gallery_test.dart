import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_state.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/new_recipe/bottom_sheet_pick_image.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_gallery.dart';
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
          home: Scaffold(body: ItemNewGallery()),
        ),
      ));

  testWidgets("Should render correct title gallery",
      (WidgetTester tester) async {
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    await tester.pumpWidget(_widget);
    final textFinder = find.text("Gallery");
    expect(textFinder, findsOneWidget);
  });

  testWidgets("Should render upload image button ",
      (WidgetTester tester) async {
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    await tester.pumpWidget(_widget);
    final buttonFinder = find.descendant(
        of: find.byType(InkWell),
        matching: find.text("Upload Images or Open Camera"));

    expect(buttonFinder, findsOneWidget);
  });

  testWidgets(
      "Should add one image into imageGallery when [NewRecipeAddImageGallerySuccess] is called",
      (WidgetTester tester) async {
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    await tester.pumpWidget(_widget);
    final StatefulElement _itemNewGalleryElement =
        tester.element(find.byType(ItemNewGallery));
    final _itemNewGallery = _itemNewGalleryElement.state as ItemNewGalleryState;
    final fakeImageFile = File("file_path");

    _newRecipeBloc.emit(NewRecipeAddImageGallerySuccess([fakeImageFile]));
    await tester.pump();
    expect(_itemNewGallery.imageGallerys[0], fakeImageFile);
  });

  testWidgets("Test second InkWell onTap()", (WidgetTester tester) async {
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    await tester.pumpWidget(_widget);
    final secondInkWell = find.descendant(
        of: find.byType(Padding), matching: find.byType(InkWell).last);
    await tester.tap(secondInkWell);
    await tester.pumpAndSettle();
    expect(find.byType(BottomSheetPickImage), findsOneWidget);
  });
  testWidgets(
      "Add over 7 images into imageGallery when [NewRecipeAddImageGallerySuccess] is called",
      (WidgetTester tester) async {
    Device.screenHeight = 1500;
    Device.screenWidth = 1500;
    Device.devicePixelRatio = 1;
    await tester.pumpWidget(_widget);
    final StatefulElement _itemNewGalleryElement =
        tester.element(find.byType(ItemNewGallery));
    final _itemNewGallery = _itemNewGalleryElement.state as ItemNewGalleryState;
    _itemNewGallery.imageOverbalance = 1;
    final fakeImageFile = [
      File("file_path"),
      File("file_path"),
      File("file_path"),
      File("file_path"),
      File("file_path"),
      File("file_path"),
      File("file_path"),
    ];

    _newRecipeBloc.emit(NewRecipeAddImageGallerySuccess(fakeImageFile));
    await tester.pump();
    final textFinder =
        find.descendant(of: find.byType(Opacity), matching: find.byType(Image));
    expect(textFinder, findsOneWidget);
  });
}
