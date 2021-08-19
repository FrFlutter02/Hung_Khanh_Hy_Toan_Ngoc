import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/services/search_services.dart';

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
        String recipeTextFieldValue =
            (event as SearchTextFieldChanged).recipeTextFieldValue;
        yield SearchTextFieldChangeSuccess(
            recipeTextFieldValue: recipeTextFieldValue);
        if (recipeTextFieldValue.isNotEmpty) {
          add(SearchRecipeRequested(searchQuery: recipeTextFieldValue));
        }
        break;

      case SearchRecipeRequested:
        try {
          yield SearchRecipeInProgress();
          final recipes = await searchServices
              .searcRecipesByName((event as SearchRecipeRequested).searchQuery);
          if (recipes.isNotEmpty) {
            yield SearchRecipeSuccess(recipes: recipes);
          } else {
            yield SearchRecipeFailure(
                failureMessage: SearchScreenText.searchFailureMessage);
          }
        } catch (e) {
          yield SearchRecipeFailure(failureMessage: e.toString());
        }
        break;
    }
  }
}
