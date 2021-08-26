import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/gallery_model.dart';
import '../../services/new_recipe_services.dart';
import '../../models/how_to_cook_model.dart';
import '../../models/ingredients_model.dart';
import 'new_recipe_event.dart';
import 'new_recipe_state.dart';

class NewRecipeBloc extends Bloc<NewRecipeEvent, NewRecipeState> {
  NewRecipeBloc() : super(NewRecipeInitial());
  File imageMain = File('');
  File imageIngredient = File('');
  List<File> imageGallerys = [];
  List<IngredientModel> ingredientList = [];
  List<HowToCookModel> stepList = [];
  String directions = '';
  String servingTime = "";
  String nutritionFact = "";
  String tags = "";
  @override
  Stream<NewRecipeState> mapEventToState(NewRecipeEvent event) async* {
    switch (event.runtimeType) {
      case NewRecipeMainImagePicked:
        event as NewRecipeMainImagePicked;
        try {
          yield NewRecipeLoading();
          final XFile? image =
              await ImagePicker().pickImage(source: event.imageSource);
          imageMain = File(image!.path);
          yield NewRecipeAddImageMainSuccess(imageMain);
        } catch (e) {
          yield NewRecipeAddImageMainFailure();
        }
        break;

      case NewRecipeGalleryImagePicked:
        event as NewRecipeGalleryImagePicked;
        try {
          yield NewRecipeLoading();
          if (event.imageSource == ImageSource.camera) {
            final XFile? image =
                await ImagePicker().pickImage(source: event.imageSource);
            imageGallerys.add(File(image!.path));
            yield NewRecipeAddImageGallerySuccess(imageGallerys);
          } else {
            final List<XFile?>? images = await ImagePicker().pickMultiImage();
            List<File> listImages = [];
            images!.map((e) => listImages.add(File(e!.path))).toList();
            imageGallerys.addAll(listImages);
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
        yield NewRecipeLoading();

        String mainImage = "";
        List<GalleryModel> galleryUploadList = [];
        List<IngredientUpLoadModel> ingredientUpLoadList = [];
        if (imageMain != File("")) {
          mainImage = await NewRecipeServices.upLoadImage(imageMain);
        }
        if (imageGallerys != []) {
          galleryUploadList =
              await NewRecipeServices.upLoadGallery(imageGallerys);
        }
        if (ingredientList != []) {
          ingredientUpLoadList =
              await NewRecipeServices.upLoadIngredient(ingredientList);
        }

        try {
          await NewRecipeServices.addNewRecipeFirebase(
              mainImage,
              event.nameRecipe,
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
    }
  }
}
