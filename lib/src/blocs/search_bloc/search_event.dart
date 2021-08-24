import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchTextFieldChanged extends SearchEvent {
  final String recipeTextFieldValue;

  const SearchTextFieldChanged({required this.recipeTextFieldValue});

  @override
  List<Object> get props => [recipeTextFieldValue];
}

class SearchRecipeRequested extends SearchEvent {
  final String searchQuery;

  const SearchRecipeRequested({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}

class SearchAutofilled extends SearchEvent {
  final String autofillValue;

  const SearchAutofilled({required this.autofillValue});

  @override
  List<Object> get props => [autofillValue];
}

class SearchInitialReturned extends SearchEvent {
  @override
  List<Object?> get props => [];
}
