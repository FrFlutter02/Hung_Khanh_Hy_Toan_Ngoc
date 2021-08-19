import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/search_bloc/search_bloc.dart';
import 'package:mobile_app/src/blocs/search_bloc/search_event.dart';
import 'package:mobile_app/src/blocs/search_bloc/search_state.dart';
import 'package:mobile_app/src/models/recipe_model.dart';
import 'package:mobile_app/src/services/search_services.dart';
import 'package:mockito/mockito.dart';

import '../../cloud_firestore_mock.dart';

final String fakeErrorMessage = 'An error was occurred!';
final String fakeNoResultMessage = 'No result was found';
final String fakeValidSearchValue = 'chicken';
final fakeRecipes = [
  RecipeModel(name: 'result 1'),
  RecipeModel(name: 'result 2'),
];

class MockSearchServices extends Mock implements SearchServices {
  @override
  Future<List<RecipeModel>> searcRecipesByName(String searchQuery) async {
    if (searchQuery.isEmpty) {
      throw fakeNoResultMessage;
    }
    if (searchQuery == fakeValidSearchValue) {
      return fakeRecipes;
    }
    throw fakeErrorMessage;
  }
}

void main() {
  MockSearchServices mockSearchServices = MockSearchServices();
  SearchBloc searchBloc = SearchBloc(searchServices: mockSearchServices);

  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  tearDown(() {
    searchBloc.close();
  });

  blocTest('emits [] when no event is called',
      build: () {
        return SearchBloc(searchServices: mockSearchServices);
      },
      expect: () => []);

  blocTest(
      'emits [SearchRecipeInProgress()] then [SearchRecipeSuccess(recipes: fakeRecipes)] when [SearchRecipeRequested] is called',
      build: () {
        return SearchBloc(searchServices: mockSearchServices);
      },
      act: (SearchBloc searchBloc) {
        when(searchBloc
            .add(SearchRecipeRequested(searchQuery: fakeValidSearchValue)));
      },
      expect: () => [
            SearchRecipeInProgress(),
            SearchRecipeSuccess(recipes: fakeRecipes),
          ]);

  blocTest(
      'emits [SearchRecipeFailure(failureMessage: \'$fakeNoResultMessage\')] when [SearchRecipeRequested] is called and search query is empty',
      build: () {
        return SearchBloc(searchServices: mockSearchServices);
      },
      act: (SearchBloc searchBloc) {
        when(searchBloc.add(SearchRecipeRequested(searchQuery: '')));
      },
      expect: () => [
            SearchRecipeInProgress(),
            SearchRecipeFailure(failureMessage: fakeNoResultMessage),
          ]);

  blocTest(
      'emits [SearchRecipeFailure(failureMessage: \'$fakeErrorMessage\')] when [SearchRecipeRequested] is called and service throws error',
      build: () {
        return SearchBloc(searchServices: mockSearchServices);
      },
      act: (SearchBloc searchBloc) {
        when(searchBloc.add(SearchRecipeRequested(searchQuery: 'hamburger')));
      },
      expect: () => [
            SearchRecipeInProgress(),
            SearchRecipeFailure(failureMessage: fakeErrorMessage),
          ]);
}
