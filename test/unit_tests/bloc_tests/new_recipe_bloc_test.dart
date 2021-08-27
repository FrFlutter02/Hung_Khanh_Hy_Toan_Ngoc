import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_event.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_state.dart';

import '../../cloud_firestore_mock.dart';

void main() {
  late NewRecipeBloc newRecipeBloc;
  File mockFile = File("/path");
  String nameRecipe = "abc";
  String fakeLink = "http/:...";
  // FirebaseStorage storage =
  //     FirebaseStorage.instanceFor(bucket: 'secondary-storage-bucket');
  // Reference ref = FirebaseStorage.instance.ref("test/").child('');

  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/image_picker');

  final List<MethodCall> log = <MethodCall>[];

  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();

    final image = File(mockFile.path);
  });
  setUp(() {
    newRecipeBloc = NewRecipeBloc();
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      log.add(methodCall);
      return '';
    });

    log.clear();
  });

  tearDown(() {
    newRecipeBloc.close();
  });

  blocTest('emits [] when no event is called',
      build: () => newRecipeBloc, expect: () => []);
  blocTest(
      'emits [NewRecipeAddImageMainSuccess] when [NewRecipeMainImagePicked] is called ',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) async {
        newRecipeBloc.add(NewRecipeMainImagePicked(ImageSource.camera));
      },
      expect: () => [
            NewRecipeLoading(),
            isA<NewRecipeAddImageMainSuccess>(),
          ]);
  blocTest(
      'emits [NewRecipeAddImageIngredientSuccess] then [NewRecipeIngredientImagePicked] ',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) async {
        newRecipeBloc.add(NewRecipeIngredientImagePicked(ImageSource.camera));
      },
      expect: () => [
            isA<NewRecipeAddImageIngredientSuccess>(),
          ]);
  blocTest(
      'emits [NewRecipeAddIngredientSuccess] when [NewRecipeAddIngredientSubmitted] ',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) => newRecipeBloc
          .add(NewRecipeAddIngredientSubmitted(nameRecipe, mockFile)),
      expect: () => [
            isA<NewRecipeAddIngredientSuccess>(),
          ]);
  blocTest(
      'emits [NewRecipeAddStepHowToCookSuccess] when [NewRecipeAddStepHowToCookSubmitted] is called ',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) => newRecipeBloc
          .add(NewRecipeAddStepHowToCookSubmitted(1, "step 1", "00:03:00")),
      expect: () => [
            isA<NewRecipeAddStepHowToCookSuccess>(),
          ]);
  blocTest(
      'emits [NewRecipeAddLinkHowToCookSuccess] when [NewRecipeAddLinkHowToCookSubmitted] is called ',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) =>
          newRecipeBloc.add(NewRecipeAddLinkHowToCookSubmitted(fakeLink)),
      expect: () => [
            NewRecipeAddLinkHowToCookSuccess(fakeLink),
          ]);
  blocTest(
      'emits [NewRecipeAddImageGallerySuccess] when [NewRecipeGalleryImagePicked] is called ',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) =>
          newRecipeBloc.add(NewRecipeGalleryImagePicked(ImageSource.camera)),
      expect: () => [
            NewRecipeLoading(),
            isA<NewRecipeAddImageGallerySuccess>(),
          ]);
  blocTest(
      'emits [NewRecipeSaveRecipeSuccess] when [NewRecipeSaved] is called ',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) =>
          newRecipeBloc.add(NewRecipeGalleryImagePicked(ImageSource.gallery)),
      expect: () => [
            NewRecipeLoading(),
            isA<NewRecipeAddImageIngredientFailure>(),
          ]);
  blocTest('emits [NewRecipeSaveRecipeSuccess] when [NewRecipeSaved] ',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) =>
          newRecipeBloc.add(NewRecipeSaved("name recipe", "catalog")),
      expect: () => [
            NewRecipeLoading(),
            NewRecipeSaveRecipeSuccess(),
          ]);
}
