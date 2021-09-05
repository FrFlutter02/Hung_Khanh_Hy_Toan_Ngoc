import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_event.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_state.dart';
import 'package:mobile_app/src/models/category.dart';
import 'package:mobile_app/src/models/gallery_model.dart';
import 'package:mobile_app/src/models/how_to_cook_model.dart';
import 'package:mobile_app/src/models/ingredients_model.dart';
import 'package:mobile_app/src/services/create_recipe_services.dart';
import 'package:mocktail/mocktail.dart';

import '../../cloud_firestore_mock.dart';

String fakeLink = "http/:...";
GalleryModel galleryModel = GalleryModel(id: "123", link: "linkGallery");
IngredientUpLoadModel ingredientUpLoadModel =
    IngredientUpLoadModel(id: "123", ingredient: "ingredient", image: "image");

class MockNewRecipeServices extends Mock implements CreateRecipeServices {
  @override
  Future<void> addNewRecipeFirebase(
    String mainImage,
    String user,
    String nameRecipe,
    List<GalleryModel> galleryList,
    List<IngredientUpLoadModel> ingredientUpLoadList,
    String directions,
    List<HowToCookModel> stepList,
    String servingTime,
    String nutritionFact,
    List<String> tags,
    String category,
  ) async {
    NewRecipeSaveRecipeSuccess();
  }

  @override
  Future<List<CategoryModel>> countRecipesInACategory(
      {required String userId}) async {
    return [CategoryModel(categoryName: "newCategory", totalRecipes: 1)];
  }

  @override
  Future<String> upLoadImage(File file) async {
    return fakeLink;
  }

  @override
  Future<List<GalleryModel>> upLoadGallery(List<File> imageGallerys) async {
    return [galleryModel];
  }

  @override
  Future<List<IngredientUpLoadModel>> upLoadIngredient(
      List<IngredientModel> imageIngredient) async {
    return [ingredientUpLoadModel];
  }
}

void main() {
  late MockNewRecipeServices mockNewRecipeServices;
  late NewRecipeBloc newRecipeBloc;
  File mockFile = File("/path");
  String nameRecipe = "abc";
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/image_picker');
  final List<MethodCall> log = <MethodCall>[];

  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });
  setUp(() {
    mockNewRecipeServices = MockNewRecipeServices();
    newRecipeBloc = NewRecipeBloc(newRecipeServices: mockNewRecipeServices);
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
      'emits [NewRecipeAddImageMainSuccess] when [NewRecipeMainImagePicked] is called is called',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) async {
        newRecipeBloc.add(NewRecipeMainImagePicked(ImageSource.camera));
      },
      expect: () => [
            isA<NewRecipeAddImageMainSuccess>(),
          ]);
  blocTest(
      'emits [NewRecipeAddImageIngredientSuccess] then [NewRecipeIngredientImagePicked] is called',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) async {
        newRecipeBloc.add(NewRecipeIngredientImagePicked(ImageSource.camera));
      },
      expect: () => [
            isA<NewRecipeAddImageIngredientSuccess>(),
          ]);
  blocTest(
      'emits [NewRecipeAddIngredientSuccess] when [NewRecipeAddIngredientSubmitted] is called',
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
            isA<NewRecipeAddImageGallerySuccess>(),
          ]);
  blocTest(
      'emits [NewRecipeAddCategorySubmitted] when [NewRecipeAddCategorySubmitted] is called ',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) =>
          newRecipeBloc.add(NewRecipeAddCategorySubmitted("newCategory")),
      expect: () => [
            NewRecipeAddCategorySuccess("newCategory"),
          ]);
  blocTest(
      'emits [NewRecipeCategoriesLoadFailure] when [NewRecipeGetCategoriesRequested] is called ',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) =>
          newRecipeBloc.add(NewRecipeGetCategoriesRequested("user")),
      expect: () => [
            NewRecipeCategoriesLoadSuccess(categories: [
              CategoryModel(categoryName: "newCategory", totalRecipes: 1)
            ])
          ]);
  blocTest('emits [NewRecipeSaveRecipeSuccess] when [NewRecipeSaved] is called',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) {
        newRecipeBloc.directions = "link";
        newRecipeBloc.ingredientList = [
          IngredientModel(id: "123", ingredient: "ingredient", image: mockFile)
        ];
        newRecipeBloc.add(NewRecipeSaved("name recipe", "user"));
      },
      expect: () => [
            NewRecipeLoading(),
            NewRecipeSaveRecipeSuccess(),
          ]);
  blocTest('emits [NewRecipeSaveRecipeSuccess] when [NewRecipeSaved] is called',
      build: () => newRecipeBloc,
      act: (NewRecipeBloc newRecipeBloc) {
        newRecipeBloc.directions = "";
        newRecipeBloc.ingredientList = [];
        newRecipeBloc.add(NewRecipeSaved("", "user"));
      },
      expect: () => [
            NewRecipeLoading(),
            isA<NewRecipeValidateFailure>(),
          ]);
}
