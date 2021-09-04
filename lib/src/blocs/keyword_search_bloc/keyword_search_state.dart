import 'package:equatable/equatable.dart';

import '../../models/recipe_model.dart';

abstract class KeywordSearchState extends Equatable {
  const KeywordSearchState();

  @override
  List<Object> get props => [];
}

class KeywordSearchInitial extends KeywordSearchState {}

class SearchTextFieldChangeSuccess extends KeywordSearchState {
  final String recipeTextFieldValue;

  const SearchTextFieldChangeSuccess({required this.recipeTextFieldValue});

  @override
  List<Object> get props => [recipeTextFieldValue];
}

class KeywordSearchRecipeInProgress extends KeywordSearchState {}

class KeywordSearchRecipeSuccess extends KeywordSearchState {
  final List<RecipeModel> recipes;

  const KeywordSearchRecipeSuccess({required this.recipes});

  @override
  List<Object> get props => [recipes];
}

class KeywordSearchRecipeFailure extends KeywordSearchState {
  final String failureMessage;

  const KeywordSearchRecipeFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

class KeywordSearchAutofillSuccess extends KeywordSearchState {
  final String autofillValue;

  const KeywordSearchAutofillSuccess({required this.autofillValue});

  @override
  List<Object> get props => [autofillValue];
}
