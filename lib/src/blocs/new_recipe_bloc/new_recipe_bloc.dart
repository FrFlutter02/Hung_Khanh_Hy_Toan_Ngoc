import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/new_recipe_validator.dart';
import '../../models/gallery_model.dart';
import '../../services/new_recipe_services.dart';
import '../../models/how_to_cook_model.dart';
import '../../models/ingredients_model.dart';
import 'new_recipe_event.dart';
import 'new_recipe_state.dart';

class NewRecipeBloc extends Bloc<NewRecipeEvent, NewRecipeState> {
  NewRecipeBloc() : super(NewRecipeInitial());
  File mainImage = File('');
  File imageIngredient = File('');
  List<File> gallery = [];
  List<IngredientModel> ingredientList = [];
  List<HowToCookModel> stepList = [];
  String directions = '';
  String servingTime = "";
  String nutritionFact = "";
  List<String> tags = [];
  @override
  Stream<NewRecipeState> mapEventToState(NewRecipeEvent event) async* {
    switch (event.runtimeType) {
      case NewRecipeMainImagePicked:
        event as NewRecipeMainImagePicked;
        try {
          final XFile? image =
              await ImagePicker().pickImage(source: event.imageSource);
          mainImage = File(image!.path);
          yield NewRecipeAddImageMainSuccess(mainImage);
        } catch (e) {
          yield NewRecipeAddImageMainFailure();
        }
        break;

      case NewRecipeGalleryImagePicked:
        event as NewRecipeGalleryImagePicked;
        try {
          if (event.imageSource == ImageSource.camera) {
            final XFile? image =
                await ImagePicker().pickImage(source: event.imageSource);
            gallery.add(File(image!.path));
            yield NewRecipeAddImageGallerySuccess(gallery);
          } else {
            final List<XFile?>? images = await ImagePicker().pickMultiImage();
            List<File> listImages = [];
            images!.map((e) => listImages.add(File(e!.path))).toList();
            gallery.addAll(listImages);
            yield NewRecipeAddImageGallerySuccess(listImages);
          }
        } catch (e) {
          yield NewRecipeAddImageIngredientFailure();
        }
        break;

      case NewRecipeIngredientImagePicked:
        event as NewRecipeIngredientImagePicked;
        try {
          final XFile? image =
              await ImagePicker().pickImage(source: event.imageSource);
          imageIngredient = File(image!.path);
          yield NewRecipeAddImageIngredientSuccess(imageIngredient);
        } catch (e) {
          yield NewRecipeAddImageIngredientFailure();
        }
        break;

      case NewRecipeAddIngredientSubmitted:
        event as NewRecipeAddIngredientSubmitted;
        if (event.nameIngredient.isEmpty) return;
        try {
          final ingredient = IngredientModel(
            id: DateTime.now().toString(),
            ingredient: event.nameIngredient,
            image: event.image,
          );
          ingredientList.add(ingredient);
          yield NewRecipeAddIngredientSuccess(ingredient);
        } catch (e) {
          yield NewRecipeAddIngredientFailure();
        }
        break;

      case NewRecipeAddLinkHowToCookSubmitted:
        event as NewRecipeAddLinkHowToCookSubmitted;
        directions = event.directions;
        yield NewRecipeAddLinkHowToCookSuccess(directions);
        break;

      case NewRecipeAddStepHowToCookSubmitted:
        event as NewRecipeAddStepHowToCookSubmitted;
        try {
          final step = HowToCookModel(
            id: DateTime.now().toString(),
            step: event.step,
            textHowToCook: event.stepText,
            duration: event.duration,
          );
          stepList.add(step);
          yield NewRecipeAddStepHowToCookSuccess(step);
        } catch (e) {
          yield NewRecipeAddStepHowToCookFailure();
        }
        break;

      case NewRecipeSaveAdditionalInfoSubmitted:
        event as NewRecipeSaveAdditionalInfoSubmitted;
        servingTime = event.servingTime;
        nutritionFact = event.nutritionFact;
        tags = event.tags;
        break;

      case NewRecipeSaved:
        event as NewRecipeSaved;
        String mainImageUrl = "";
        List<GalleryModel> galleryUploadList = [];
        List<IngredientUpLoadModel> ingredientUpLoadList = [];

        final errorList = [
          NewRecipeValidator.validateMainImage(mainImage),
          NewRecipeValidator.validateRecipeName(event.recipeName),
          NewRecipeValidator.validateGallery(gallery),
          NewRecipeValidator.validateIngredients(ingredientList),
          NewRecipeValidator.validateHowToCook(directions),
        ];
        final hasError = errorList.any((error) => error.isNotEmpty);
        if (hasError) {
          yield NewRecipeValidateFailure(
            mainImageErrorMessage: errorList[0],
            recipeNameErrorMessage: errorList[1],
            galleryErrorMessage: errorList[2],
            ingredientsErrorMessage: errorList[3],
            howToCookErrorMessage: errorList[4],
          );
          return;
        } else
          yield NewRecipeValidateSuccess();

        if (mainImage != File("")) {
          mainImageUrl = await NewRecipeServices.upLoadImage(mainImage);
        }
        if (gallery != []) {
          galleryUploadList = await NewRecipeServices.upLoadGallery(gallery);
        }
        if (ingredientList.isNotEmpty) {
          ingredientUpLoadList =
              await NewRecipeServices.upLoadIngredient(ingredientList);
        }

        try {
          yield NewRecipeLoading();
          await NewRecipeServices.addNewRecipeFirebase(
              mainImageUrl,
              event.recipeName,
              galleryUploadList,
              ingredientUpLoadList,
              directions,
              stepList,
              servingTime,
              nutritionFact,
              tags,
              event.category);
          yield NewRecipeSaveRecipeSuccess();
        } catch (e) {
          yield NewRecipeSaveRecipeFailure();
        }
        break;

      case NewRecipeGetCategoriesRequested:
        try {
          final categoriesAndTotalRecipes =
              await NewRecipeServices.countRecipesInACategory(
                  userId: 'daovantoan10234@gmail.com');
          yield NewRecipeCategoriesLoadSuccess(
              categories: categoriesAndTotalRecipes);
        } catch (e) {
          yield NewRecipeCategoriesLoadFailure();
        }
        break;
    }
  }
}
