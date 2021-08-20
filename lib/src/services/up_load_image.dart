import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/ingredients_model.dart';
import '../models/gallery_model.dart';

// FirebaseStorage storage =
//     FirebaseStorage.instanceFor(bucket: 'gs://tam-ke-flutter.appspot.com/');

class UploadFile {
  static Future<String> upLoadImage(File file) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref("test/")
          .child('${file.path.split('/').last}');
      UploadTask uploadTask = ref.putFile(file);
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String link = await taskSnapshot.ref.getDownloadURL();
      return link;
    } on FirebaseStorage catch (e) {
      print("err firebase $e");
      return "";
    }
  }

  static Future<List<GalleryModel>> upLoadGallery(
      List<File> imageGallerys) async {
    List<GalleryModel> galleryList = [];
    imageGallerys.forEach((element) async {
      String link = await UploadFile.upLoadImage(element);
      var gallery = GalleryModel(
        id: DateTime.now().toString(),
        link: link,
      );
      galleryList.add(gallery);
    });
    return galleryList;
  }

  static Future<List<IngredientUpLoadModel>> upLoadIngredient(
      List<IngredientModel> imageGallerys) async {
    List<IngredientUpLoadModel> ingredientList = [];
    imageGallerys.forEach((element) async {
      if (element.image == File("")) {
        var ingredient = IngredientUpLoadModel(
          id: element.id,
          ingredient: element.ingredient,
          image: "",
        );
        ingredientList.add(ingredient);
      } else {
        String link = await UploadFile.upLoadImage(element.image);
        var ingredient = IngredientUpLoadModel(
          id: element.id,
          ingredient: element.ingredient,
          image: link,
        );
        ingredientList.add(ingredient);
      }
    });
    return ingredientList;
  }
}
