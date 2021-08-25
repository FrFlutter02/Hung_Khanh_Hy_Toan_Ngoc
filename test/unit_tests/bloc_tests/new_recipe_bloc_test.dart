import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_event.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_state.dart';
import 'package:mobile_app/src/models/ingredients_model.dart';
import 'package:mockito/mockito.dart';

import '../../cloud_firestore_mock.dart';

void main() {
  late NewRecipeBloc newRecipeBloc;
  File mockFile = File("/path");
  String nameRecipe = "abc";
  String fakeLink = "http/:...";
  // FirebaseStorage storage =
  //     FirebaseStorage.instanceFor(bucket: 'secondary-storage-bucket');
  // Reference ref = FirebaseStorage.instance.ref("test/").child('');
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });
  setUp(() {
    newRecipeBloc = NewRecipeBloc();
  });

  tearDown(() {
    newRecipeBloc.close();
  });

  blocTest('emits [] when no event is called',
      build: () => newRecipeBloc, expect: () => []);
  blocTest(
      'emits [NewRecipeAddImageMainFailure] when [NewRecipeMainImagePicked] is called and text field is empty',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) async {
        newRecipeBloc.add(NewRecipeMainImagePicked(ImageSource.camera));
      },
      expect: () => [
            NewRecipeLoading(),
            isA<NewRecipeAddImageMainSuccess>(),
          ]);
  blocTest(
      'emits [NewRecipeIngredientImagePicked] then [NewRecipeAddImageIngredientSuccess] ',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) async {
        newRecipeBloc.add(NewRecipeIngredientImagePicked(ImageSource.camera));
      },
      expect: () => [
            isA<NewRecipeAddImageIngredientSuccess>(),
          ]);
  blocTest('emits [NewRecipeSaveRecipeSuccess] when [NewRecipeSaved] ',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) => newRecipeBloc
          .add(NewRecipeAddIngredientSubmitted(nameRecipe, mockFile)),
      expect: () => [
            isA<NewRecipeAddIngredientSuccess>(),
          ]);
  blocTest(
      'emits [NewRecipeSaveRecipeSuccess] when [NewRecipeSaved] is called and text field is empty',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) => newRecipeBloc
          .add(NewRecipeAddStepHowToCookSubmitted(1, "step 1", "00:03:00")),
      expect: () => [
            isA<NewRecipeAddStepHowToCookSuccess>(),
          ]);
  blocTest(
      'emits [NewRecipeSaveRecipeSuccess] when [NewRecipeSaved] is called and text',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) =>
          newRecipeBloc.add(NewRecipeAddLinkHowToCookSubmitted(fakeLink)),
      expect: () => [
            NewRecipeAddLinkHowToCookSuccess(fakeLink),
          ]);
  blocTest(
      'emits [NewRecipeSaveRecipeSuccess] when [NewRecipeSaved] is called and text aaaa',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) =>
          newRecipeBloc.add(NewRecipeGalleryImagePicked(ImageSource.camera)),
      expect: () => [
            NewRecipeLoading(),
            isA<NewRecipeAddImageGallerySuccess>(),
          ]);
  blocTest(
      'emits [NewRecipeSaveRecipeSuccess] when [NewRecipeSaved] is called and text aaaa',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) =>
          newRecipeBloc.add(NewRecipeGalleryImagePicked(ImageSource.gallery)),
      expect: () => [
            NewRecipeLoading(),
            isA<NewRecipeAddImageGallerySuccess>(),
          ]);
  blocTest(
      'emits [NewRecipeSaveRecipeSuccess] when [NewRecipeSaved] is empty m',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) =>
          newRecipeBloc.add(NewRecipeSaved("name recipe", "catalog")),
      expect: () => [
            NewRecipeSaveRecipeSuccess(),
          ]);
}
