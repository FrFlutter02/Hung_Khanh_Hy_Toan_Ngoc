import 'package:equatable/equatable.dart';
import 'package:mobile_app/src/models/recipe_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchTextFieldChangeSuccess extends SearchState {
  final String recipeTextFieldValue;

  const SearchTextFieldChangeSuccess({required this.recipeTextFieldValue});

  @override
  List<Object> get props => [recipeTextFieldValue];
}

class SearchRecipeInProgress extends SearchState {}

class SearchRecipeSuccess extends SearchState {
  final List<RecipeModel> recipes;

  const SearchRecipeSuccess({required this.recipes});

  @override
  List<Object> get props => [recipes];
}

class SearchRecipeFailure extends SearchState {
  final String failureMessage;

  const SearchRecipeFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

class SearchAutofillSuccess extends SearchState {
  final String autofillValue;

  const SearchAutofillSuccess({required this.autofillValue});

  @override
  List<Object> get props => [autofillValue];
}
