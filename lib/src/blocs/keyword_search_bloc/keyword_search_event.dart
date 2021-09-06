import 'package:equatable/equatable.dart';

abstract class KeywordSearchEvent extends Equatable {
  const KeywordSearchEvent();
}

class KeywordSearchTextFieldChanged extends KeywordSearchEvent {
  final String recipeTextFieldValue;

  const KeywordSearchTextFieldChanged({required this.recipeTextFieldValue});

  @override
  List<Object> get props => [recipeTextFieldValue];
}

class KeywordSearchRecipeRequested extends KeywordSearchEvent {
  final String searchQuery;

  const KeywordSearchRecipeRequested({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}

class KeywordSearchAutofilled extends KeywordSearchEvent {
  final String autofillValue;

  const KeywordSearchAutofilled({required this.autofillValue});

  @override
  List<Object> get props => [autofillValue];
}

class KeywordSearchInitialReturned extends KeywordSearchEvent {
  @override
  List<Object?> get props => [];
}
