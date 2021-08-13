import 'dart:async';

import 'package:bloc/bloc.dart';
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
      case SearchRecipeTextFieldChanged:
        String recipeTextFieldValue =
            (event as SearchRecipeTextFieldChanged).recipeTextFieldValue;
        yield SearchRecipeTextFieldChangeSuccess(
            recipeTextFieldValue: recipeTextFieldValue);
        if (recipeTextFieldValue.isNotEmpty) {
          yield SearchFindRecipeInProgress();
          add(SearchRecipeSearchRequested(searchQuery: recipeTextFieldValue));
        }
        break;

      case SearchRecipeSearchRequested:
        try {
          final recipes = await searchServices.searcRecipesByName(
              (event as SearchRecipeSearchRequested).searchQuery);
          yield SearchFindRecipeSuccess(recipes: recipes);
        } catch (e) {
          yield SearchFindRecipeFailure(errorMessage: e.toString());
        }
        break;
    }
  }
}
