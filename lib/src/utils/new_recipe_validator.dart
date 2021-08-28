import 'dart:io';

import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/models/ingredients_model.dart';

class NewRecipeValidator {
  static String validateMainImage(File mainImage) {
    if (mainImage.path.isEmpty) {
      return NewRecipeText.mainImageErrorText;
    }
    return '';
  }

  static String validateRecipeName(String recipeName) {
    if (recipeName.isEmpty) {
      return NewRecipeText.recipeNameErrorText;
    }
    return '';
  }

  static String validateGallery(List<File> galleryList) {
    if (galleryList.isEmpty) {
      return NewRecipeText.galleryMustNotBeEmptyErrorText;
    }
    return '';
  }

  static String validateIngredients(List<IngredientModel> ingredientList) {
    if (ingredientList.isEmpty) {
      return NewRecipeText.ingredientsMustNotBeEmptyErrorText;
    }
    return '';
  }

  static String validateHowToCook(String direction) {
    if (direction.isEmpty) {
      return NewRecipeText.howToCookMustNotBeEmptyErrorText;
    }
    return '';
  }
}
