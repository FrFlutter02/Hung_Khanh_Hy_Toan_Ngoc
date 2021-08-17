import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchRecipeTextFieldChanged extends SearchEvent {
  final String recipeTextFieldValue;

  const SearchRecipeTextFieldChanged({required this.recipeTextFieldValue});
}

class SearchRecipeRequested extends SearchEvent {
  final String searchQuery;

  const SearchRecipeRequested({required this.searchQuery});
}
