import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/search_bloc/search_bloc.dart';
import 'package:mobile_app/src/blocs/search_bloc/search_event.dart';
import 'package:mobile_app/src/blocs/search_bloc/search_state.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/models/recipe_model.dart';
import 'package:mobile_app/src/services/search_services.dart';
import 'package:mockito/mockito.dart';

import '../../cloud_firestore_mock.dart';

final String fakeValidSearchValue = 'Chicken';
final String fakeNoResultValue = 'Fake no result';
final fakeRecipes = [
  RecipeModel(name: 'Chicken 1'),
  RecipeModel(name: 'Chicken 2'),
];

class MockSearchServices extends Mock implements SearchServices {
  @override
  Future<List<RecipeModel>> searcRecipesByName(String searchQuery) async {
    if (searchQuery == fakeValidSearchValue) {
      return fakeRecipes;
    }
    if (searchQuery == fakeNoResultValue) {
      return [];
    }
    throw Exception();
  }
}

void main() {
  late MockSearchServices mockSearchServices;
  late SearchBloc searchBloc;

  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  setUp(() {
    mockSearchServices = MockSearchServices();
    searchBloc = SearchBloc(searchServices: mockSearchServices);
  });

  tearDown(() {
    searchBloc.close();
  });

  blocTest('emits [] when no event is called',
      build: () => searchBloc, expect: () => []);

  blocTest(
      'emits [SearchTextFieldChangeSuccess] when [SearchTextFieldChanged] is called and text field is empty',
      build: () => searchBloc,
      act: (SearchBloc searchBloc) =>
          searchBloc.add(SearchTextFieldChanged(recipeTextFieldValue: '')),
      expect: () => [
            SearchTextFieldChangeSuccess(recipeTextFieldValue: ''),
          ]);

  blocTest(
      'emits [SearchTextFieldChangeSuccess] then [SearchRecipeInProgress] then [SearchRecipeSuccess(recipes:...)] when [SearchTextFieldChanged] is called and text field is not empty',
      build: () => searchBloc,
      act: (SearchBloc searchBloc) => searchBloc.add(
          SearchTextFieldChanged(recipeTextFieldValue: fakeValidSearchValue)),
      expect: () => [
            SearchTextFieldChangeSuccess(
                recipeTextFieldValue: fakeValidSearchValue),
            SearchRecipeInProgress(),
            SearchRecipeSuccess(recipes: fakeRecipes),
          ]);

  blocTest(
      'emits [SearchRecipeInProgress] then [SearchRecipeSuccess(recipes: fakeRecipes)] when [SearchRecipeRequested] is called',
      build: () => searchBloc,
      act: (SearchBloc searchBloc) => searchBloc
          .add(SearchRecipeRequested(searchQuery: fakeValidSearchValue)),
      expect: () => [
            SearchRecipeInProgress(),
            SearchRecipeSuccess(recipes: fakeRecipes),
          ]);

  blocTest(
      'emits [SearchRecipeFailure(failureMessage:...)] when [SearchRecipeRequested] is called and no result was found',
      build: () => searchBloc,
      act: (SearchBloc searchBloc) =>
          searchBloc.add(SearchRecipeRequested(searchQuery: fakeNoResultValue)),
      expect: () => [
            SearchRecipeInProgress(),
            SearchRecipeFailure(
                failureMessage: SearchScreenText.searchNoResultMessage),
          ]);

  blocTest(
      'emits [SearchRecipeFailure(failureMessage:...)] when [SearchRecipeRequested] is called and service throws error',
      build: () => searchBloc,
      act: (SearchBloc searchBloc) =>
          searchBloc.add(SearchRecipeRequested(searchQuery: 'error')),
      expect: () => [
            SearchRecipeInProgress(),
            SearchRecipeFailure(
                failureMessage: SearchScreenText.searchErrorMessage),
          ]);

  blocTest(
      'emits [] when [SearchAutofilled] is called and autofill value is empty',
      build: () => searchBloc,
      act: (SearchBloc searchBloc) =>
          searchBloc.add(SearchAutofilled(autofillValue: '')),
      expect: () => []);

  blocTest(
      'emits [] when [SearchAutofilled] then [SearchInitial] is called and autofill value is not empty',
      build: () => searchBloc,
      act: (SearchBloc searchBloc) =>
          searchBloc.add(SearchAutofilled(autofillValue: 'autofill')),
      expect: () =>
          [SearchAutofillSuccess(autofillValue: 'autofill'), SearchInitial()]);
}
