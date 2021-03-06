import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../models/category.dart';
import '../models/how_to_cook_model.dart';
import '../models/ingredients_model.dart';
import '../models/gallery_model.dart';

class CreateRecipeServices {
  Future<String> upLoadImage(File file) async {
    try {
      String link = "";
      Reference ref = FirebaseStorage.instance
          .ref("New Recipe/")
          .child('${file.path.split('/').last}');
      await ref.putFile(file).whenComplete(() async {
        link = await ref.getDownloadURL();
      });
      return link;
    } on FirebaseStorage catch (e) {
      return "";
    }
  }

  Future<List<GalleryModel>> upLoadGallery(List<File> imageGallerys) async {
    List<GalleryModel> galleryList = [];
    await Future.wait(imageGallerys.map((element) async {
      String link = await upLoadImage(element);
      var gallery = GalleryModel(
        id: Uuid().v1(),
        link: link,
      );
      galleryList.add(gallery);
    }));
    return galleryList;
  }

  Future<List<IngredientUpLoadModel>> upLoadIngredient(
      List<IngredientModel> imageIngredient) async {
    List<IngredientUpLoadModel> ingredientList = [];
    await Future.wait(imageIngredient.map((element) async {
      if (element.image.path == "") {
        var ingredient = IngredientUpLoadModel(
          id: element.id,
          ingredient: element.ingredient,
          image: "",
        );
        ingredientList.add(ingredient);
      } else {
        String link = await upLoadImage(element.image);
        var ingredient = IngredientUpLoadModel(
          id: element.id,
          ingredient: element.ingredient,
          image: link,
        );
        ingredientList.add(ingredient);
      }
    }));
    return ingredientList;
  }

  Future<List<CategoryModel>> countRecipesInACategory(
      {required String userId}) async {
    List<CategoryModel> result = [];
    Map<String, dynamic> categoryAndTotalRecipesMap = {};
    await FirebaseFirestore.instance
        .collection('recipe')
        .where('userId', isEqualTo: userId)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        categoryAndTotalRecipesMap.update(
            element['category'], (value) => value + 1,
            ifAbsent: () => 1);
      });
    });
    categoryAndTotalRecipesMap.forEach((key, value) =>
        result.add(CategoryModel(categoryName: key, totalRecipes: value)));
    return result;
  }

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
    FirebaseFirestore.instance.collection('recipe').doc().set({
      'id': Uuid().v1(),
      "mainImage": mainImage,
      "userId": user,
      "nameRecipe": nameRecipe,
      "galleryList": galleryList.map((e) => e.toJson()).toList(),
      "ingredientList": ingredientUpLoadList.map((e) => e.toJson()).toList(),
      "direction": directions,
      "stepList": stepList.map((e) => e.toJson()).toList(),
      "servingTime": servingTime,
      "nutritionFact": nutritionFact,
      "tags": tags,
      "category": category,
    });
  }
}
