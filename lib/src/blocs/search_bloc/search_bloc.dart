import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../constants/constant_text.dart';
import '../../services/search_services.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchServices searchServices;

  SearchBloc({required this.searchServices}) : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    switch (event.runtimeType) {
      case SearchTextFieldChanged:
        yield* mapSearchTextFieldChangedToState(
            event as SearchTextFieldChanged);
        break;
      case SearchRecipeRequested:
        yield* mapSearchRecipeRequestedToState(event as SearchRecipeRequested);
        break;
      case SearchAutofilled:
        yield* mapSearchAutofilledToState(event as SearchAutofilled);
        break;
      case SearchInitialReturned:
        yield SearchInitial();
        break;
    }
  }

  Stream<SearchState> mapSearchTextFieldChangedToState(
      SearchTextFieldChanged event) async* {
    String recipeTextFieldValue = event.recipeTextFieldValue;
    yield SearchTextFieldChangeSuccess(
        recipeTextFieldValue: recipeTextFieldValue);
    if (recipeTextFieldValue.isNotEmpty) {
      add(SearchRecipeRequested(searchQuery: recipeTextFieldValue));
    }
  }

  Stream<SearchState> mapSearchRecipeRequestedToState(
      SearchRecipeRequested event) async* {
    try {
      yield SearchRecipeInProgress();
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
        yield SearchRecipeSuccess(recipes: recipes);
      } else {
        yield SearchRecipeFailure(
            failureMessage: SearchScreenText.searchNoResultMessage);
      }
    } catch (e) {
      yield SearchRecipeFailure(
          failureMessage: SearchScreenText.searchErrorMessage);
    }
  }

  Stream<SearchState> mapSearchAutofilledToState(
      SearchAutofilled event) async* {
    if (event.autofillValue.isNotEmpty) {
      yield SearchAutofillSuccess(
          autofillValue: event.autofillValue.toLowerCase());
      await Future.delayed(Duration(seconds: 1));
      yield SearchInitial();
    }
  }
}
