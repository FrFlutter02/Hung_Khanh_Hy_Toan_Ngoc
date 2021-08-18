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
      case SearchRecipeTextFieldChanged:
        String recipeTextFieldValue =
            (event as SearchRecipeTextFieldChanged).recipeTextFieldValue;
        yield SearchRecipeTextFieldChangeSuccess(
            recipeTextFieldValue: recipeTextFieldValue);
        if (recipeTextFieldValue.isNotEmpty) {
          yield SearchFindRecipeInProgress();
          add(SearchRecipeRequested(searchQuery: recipeTextFieldValue));
        }
        break;

      case SearchRecipeRequested:
        try {
          final recipes = await searchServices
              .searcRecipesByName((event as SearchRecipeRequested).searchQuery);
          if (recipes.isNotEmpty) {
            yield SearchFindRecipeSuccess(recipes: recipes);
          } else {
            yield SearchFindRecipeFailure(
                failureMessage: SearchScreenText.searchFailureMessage);
          }
        } catch (e) {
          yield SearchFindRecipeFailure(failureMessage: e.toString());
        }
        break;
    }
  }

  @override
  void onChange(Change<SearchState> change) {
    print(change);
    super.onChange(change);
  }
}
