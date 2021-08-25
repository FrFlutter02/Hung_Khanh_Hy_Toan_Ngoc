import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../constants/constant_text.dart';
import '../../services/search_services.dart';
import 'keyword_search_event.dart';
import 'keyword_search_state.dart';

class KeywordSearchBloc extends Bloc<KeywordSearchEvent, KeywordSearchState> {
  final SearchServices searchServices;

  KeywordSearchBloc({required this.searchServices})
      : super(KeywordSearchInitial());

  @override
  Stream<KeywordSearchState> mapEventToState(
    KeywordSearchEvent event,
  ) async* {
    switch (event.runtimeType) {
      case KeywordSearchTextFieldChanged:
        yield* mapSearchTextFieldChangedToState(
            event as KeywordSearchTextFieldChanged);
        break;
      case KeywordSearchRecipeRequested:
        yield* mapSearchRecipeRequestedToState(
            event as KeywordSearchRecipeRequested);
        break;
      case KeywordSearchAutofilled:
        yield* mapSearchAutofilledToState(event as KeywordSearchAutofilled);
        break;
      case KeywordSearchInitialReturned:
        yield KeywordSearchInitial();
        break;
    }
  }

  Stream<KeywordSearchState> mapSearchTextFieldChangedToState(
      KeywordSearchTextFieldChanged event) async* {
    String recipeTextFieldValue = event.recipeTextFieldValue;
    yield SearchTextFieldChangeSuccess(
        recipeTextFieldValue: recipeTextFieldValue);
    if (recipeTextFieldValue.isNotEmpty) {
      add(KeywordSearchRecipeRequested(searchQuery: recipeTextFieldValue));
    }
  }

  Stream<KeywordSearchState> mapSearchRecipeRequestedToState(
      KeywordSearchRecipeRequested event) async* {
    try {
      yield KeywordSearchRecipeInProgress();
      final recipes = await searchServices
          .searcRecipesByName(event.searchQuery)
          .then((recipes) => recipes
              .where((recipe) => recipe.name
                  .toLowerCase()
                  .startsWith(event.searchQuery.toLowerCase()))
              .toSet()
              .take(7)
              .toList());
      if (recipes.isNotEmpty) {
        yield KeywordSearchRecipeSuccess(recipes: recipes);
      } else {
        yield KeywordSearchRecipeFailure(
            failureMessage: SearchScreenText.searchNoResultMessage);
      }
    } catch (e) {
      yield KeywordSearchRecipeFailure(
          failureMessage: SearchScreenText.searchErrorMessage);
    }
  }

  Stream<KeywordSearchState> mapSearchAutofilledToState(
      KeywordSearchAutofilled event) async* {
    if (event.autofillValue.isNotEmpty) {
      yield KeywordSearchAutofillSuccess(
          autofillValue: event.autofillValue.toLowerCase());
      await Future.delayed(Duration(seconds: 1));
      yield KeywordSearchInitial();
    }
  }
}
