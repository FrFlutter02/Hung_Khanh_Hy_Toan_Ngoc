import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/src/models/gallery_model.dart';

import '../../services/up_load_image.dart';
import '../../models/how_to_cook_model.dart';
import '../../services/user_services.dart';
import '../../models/ingredients_model.dart';
import 'new_recipe_event.dart';
import 'new_recipe_state.dart';

File imageMain = File('');
File imageIngredient = File('');
List<File> imageGallerys = [];
List<IngredientModel> ingredientList = [];
List<HowToCookModel> stepList = [];
String directions = '';
String servingTime = "";
String nutritionFact = "";
String tags = "";

class NewRecipeBloc extends Bloc<NewRecipeEvent, NewRecipeState> {
  final UserServices? userServices;
  NewRecipeBloc({this.userServices}) : super(NewRecipeInitial());

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
          yield NewRecipeLoading();
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
          print(e);
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
        try {
          String mainImage = "";
          List<GalleryModel> galleryList = [];
          List<IngredientUpLoadModel> ingredientUpLoadList = [];
          // if (imageMain != File("")) {
          //   mainImage = await UploadFile.upLoadImage(imageMain);
          // }

          // if (imageGallerys != []) {
          //   galleryList = await UploadFile.upLoadGallery(imageGallerys);
          // }
          // if (ingredientList != []) {
          //   ingredientUpLoadList =
          //       await UploadFile.upLoadIngredient(ingredientList);
          // }

          await FirebaseFirestore.instance
              .collection('recipe')
              .doc("daovantoan10234@gmail.com")
              .set({
            'id': DateTime.now().toString(),
            "mainImage": mainImage,
            "nameRecipe": event.nameRecipe,
            "galleryList": galleryList,
            "ingredientList": ingredientUpLoadList,
            "direction": directions,
            "stepList": stepList,
            "servingTime": servingTime,
            "nutritionFact": nutritionFact,
            "tags": tags,
            "category": event.category,
          });
          yield NewRecipeSaveRecipeSuccess();
        } catch (e) {
          yield NewRecipeSaveRecipeFailure();
        }
        break;
    }
  }
}
