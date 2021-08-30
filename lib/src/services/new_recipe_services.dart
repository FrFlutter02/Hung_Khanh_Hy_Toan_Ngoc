import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobile_app/src/models/category.dart';

import '../models/how_to_cook_model.dart';
import '../models/ingredients_model.dart';
import '../models/gallery_model.dart';

class NewRecipeServices {
  static Future<String> upLoadImage(File file) async {
    try {
      String link = "";
      Reference ref = FirebaseStorage.instance
          .ref("test/")
          .child('${file.path.split('/').last}');
      await ref.putFile(file).whenComplete(() async {
        link = await ref.getDownloadURL();
      });
      return link;
    } on FirebaseStorage catch (e) {
      return "";
    }
  }

  static Future<List<GalleryModel>> upLoadGallery(
      List<File> imageGallerys) async {
    List<GalleryModel> galleryList = [];
    await Future.wait(imageGallerys.map((element) async {
      String link = await NewRecipeServices.upLoadImage(element);
      var gallery = GalleryModel(
        id: DateTime.now().toString(),
        link: link,
      );
      galleryList.add(gallery);
    }));
    return galleryList;
  }

  static Future<List<IngredientUpLoadModel>> upLoadIngredient(
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
        String link = await NewRecipeServices.upLoadImage(element.image);
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

  static Future<List<CategoryModel>> countRecipesInACategory(
      {required String userId}) async {
    List<CategoryModel> result = [];
    Map<String, dynamic> categoryAndTotalRecipesMap = {};
    await FirebaseFirestore.instance
        .collection('recipe')
        .where('user_id', isEqualTo: userId)
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

  static Future<void> addNewRecipeFirebase(
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
    FirebaseFirestore.instance
        .collection('recipe')
        .doc("daovantoan10234@gmail.com")
        .set({
      'id': DateTime.now().toString(),
      "mainImage": mainImage,
      "user_id": user,
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
