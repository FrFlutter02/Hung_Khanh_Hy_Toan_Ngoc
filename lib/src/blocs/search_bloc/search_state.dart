import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchRecipeTextFieldChangeSuccess extends SearchState {
  final String recipeTextFieldValue;
  const SearchRecipeTextFieldChangeSuccess(
      {required this.recipeTextFieldValue});
  @override
  List<Object> get props => [recipeTextFieldValue];
}

class SearchFindRecipeSuccess extends SearchState {
  final List<String> recipes;
  const SearchFindRecipeSuccess({required this.recipes});
  @override
  List<Object> get props => [recipes];
}

class SearchFindRecipeFailure extends SearchState {
  final String errorMessage;
  const SearchFindRecipeFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class SearchFindRecipeInProgress extends SearchState {}
