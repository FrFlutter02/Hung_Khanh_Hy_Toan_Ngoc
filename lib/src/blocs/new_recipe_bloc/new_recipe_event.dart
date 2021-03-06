import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class NewRecipeEvent extends Equatable {
  const NewRecipeEvent();
  @override
  List<Object?> get props => [];
}

class NewRecipeMainImagePicked extends NewRecipeEvent {
  final ImageSource imageSource;
  NewRecipeMainImagePicked(this.imageSource);
  @override
  List<Object> get props => [imageSource];
}

class NewRecipeGalleryImagePicked extends NewRecipeEvent {
  final ImageSource imageSource;
  NewRecipeGalleryImagePicked(this.imageSource);
  @override
  List<Object> get props => [imageSource];
}

class NewRecipeIngredientImagePicked extends NewRecipeEvent {
  final ImageSource imageSource;
  NewRecipeIngredientImagePicked(this.imageSource);
  @override
  List<Object> get props => [imageSource];
}

class NewRecipeAddIngredientSubmitted extends NewRecipeEvent {
  final String nameIngredient;
  final File image;
  NewRecipeAddIngredientSubmitted(this.nameIngredient, this.image);
  @override
  List<Object> get props => [nameIngredient, image];
}

class NewRecipeAddLinkHowToCookSubmitted extends NewRecipeEvent {
  final String directions;

  NewRecipeAddLinkHowToCookSubmitted(this.directions);
  @override
  List<Object> get props => [directions];
}

class NewRecipeAddStepHowToCookSubmitted extends NewRecipeEvent {
  final int step;
  final String stepText;
  final String duration;
  NewRecipeAddStepHowToCookSubmitted(this.step, this.stepText, this.duration);
  @override
  List<Object> get props => [step, stepText, duration];
}

class NewRecipeSaveAdditionalInfoSubmitted extends NewRecipeEvent {
  final String servingTime;
  final String nutritionFact;
  final List<String> tags;
  NewRecipeSaveAdditionalInfoSubmitted(
      this.servingTime, this.nutritionFact, this.tags);
  @override
  List<Object> get props => [servingTime, nutritionFact, tags];
}

class NewRecipeGetCategoriesRequested extends NewRecipeEvent {
  final String user;
  NewRecipeGetCategoriesRequested(this.user);
  @override
  List<Object> get props => [user];
}

class NewRecipeSaved extends NewRecipeEvent {
  final String recipeName;
  final String user;
  NewRecipeSaved(this.recipeName, this.user);
  @override
  List<Object> get props => [recipeName, user];
}

class NewRecipeAddCategorySubmitted extends NewRecipeEvent {
  final String category;

  NewRecipeAddCategorySubmitted(this.category);
  @override
  List<Object> get props => [category];
}
