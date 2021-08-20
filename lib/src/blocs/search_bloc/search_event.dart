import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchTextFieldChanged extends SearchEvent {
  final String recipeTextFieldValue;

  const SearchTextFieldChanged({required this.recipeTextFieldValue});
}

class SearchRecipeRequested extends SearchEvent {
  final String searchQuery;

  const SearchRecipeRequested({required this.searchQuery});
}

class SearchAutofilled extends SearchEvent {
  final String autofillValue;

  const SearchAutofilled({required this.autofillValue});
}
