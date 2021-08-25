import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/keyword_search_bloc/keyword_search_bloc.dart';
import 'package:mobile_app/src/blocs/keyword_search_bloc/keyword_search_state.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/models/recipe_model.dart';
import 'package:mobile_app/src/screens/search_screen.dart';
import 'package:mobile_app/src/services/search_services.dart';
import 'package:mobile_app/src/widgets/search/search_bar.dart';
import 'package:mockito/mockito.dart';

import '../../../cloud_firestore_mock.dart';

class MockSearchServices extends Mock implements SearchServices {}

void main() {
  late MockSearchServices mockSearchServices;
  late KeywordSearchBloc searchBloc;
  final Widget _widget = BlocProvider(
      create: (_) => searchBloc,
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          home: SearchScreen(),
        ),
      ));

  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  setUp(() {
    mockSearchServices = MockSearchServices();
    searchBloc = KeywordSearchBloc(searchServices: mockSearchServices);
  });

  tearDownAll(() {
    searchBloc.close();
  });

  testWidgets('Should render correct hint text on tablet screen',
      (WidgetTester tester) async {
    Device.width = 1920;
    Device.height = 1920;
    Device.devicePixelRatio = 2;
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    await tester.pumpWidget(_widget);

    final textFieldFinder = find.byType(TextField);
    final hintText =
        tester.widget<TextField>(textFieldFinder).decoration?.hintText;

    expect(hintText, SearchScreenText.searchHintTextTablet);
  });

  testWidgets('Should render correct hint text on phone screen',
      (WidgetTester tester) async {
    Device.width = 600;
    Device.height = 600;
    await tester.pumpWidget(_widget);

    final textFieldFinder = find.byType(TextField);
    final hintText =
        tester.widget<TextField>(textFieldFinder).decoration?.hintText;

    expect(hintText, SearchScreenText.searchHintText);
  });

  testWidgets('Should render search_icon image', (WidgetTester tester) async {
    await tester.pumpWidget(_widget);

    final imageFinder = find.byType(Image);
    final imageWidget = tester.firstWidget<Image>(imageFinder);
    final imageSource = (imageWidget.image as AssetImage).assetName;

    expect(imageSource, 'assets/images/icons/search_icon.png');
  });

  testWidgets('Should render filter_icon image', (WidgetTester tester) async {
    await tester.pumpWidget(_widget);

    final imageFinder = find.byType(Image).last;
    final imageWidget = tester.widget<Image>(imageFinder);
    final imageSource = (imageWidget.image as AssetImage).assetName;

    expect(imageSource, 'assets/images/icons/filter_icon.png');
  });

  group('Method tests', () {
    testWidgets('Test openDropdown()', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      final StatefulElement _searchBarElement =
          tester.element(find.byType(SearchBar));
      final SearchBarState _searchBarState =
          _searchBarElement.state as SearchBarState;

      _searchBarState.openDropdown(_searchBarState.context);
      final _dropdownOverlayEntry = _searchBarState.dropdownOverlayEntry;
      expect(_dropdownOverlayEntry, isNotNull);
    });

    testWidgets('Test closeDropdown()', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      final StatefulElement _searchBarElement =
          tester.element(find.byType(SearchBar));
      final SearchBarState _searchBarState =
          _searchBarElement.state as SearchBarState;

      _searchBarState.closeDropdown();
      final _dropdownOverlayEntry = _searchBarState.dropdownOverlayEntry;
      expect(_dropdownOverlayEntry, isNull);
      expect(_searchBarState.recipesByName, isEmpty);
    });

    testWidgets('Test getDropdownWidget()', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      final StatefulElement _searchBarElement =
          tester.element(find.byType(SearchBar));
      final SearchBarState _searchBarState =
          _searchBarElement.state as SearchBarState;

      searchBloc.emit(KeywordSearchRecipeInProgress());
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      _searchBarState.searchTextEditingController.text = 'chicken';
      searchBloc.emit(KeywordSearchRecipeSuccess(recipes: [
        RecipeModel(name: 'chicken 1'),
      ]));
      await tester.pump();
      expect(_searchBarState.recipesByName, [
        RecipeModel(name: 'chicken 1'),
      ]);

      searchBloc.emit(KeywordSearchRecipeFailure(failureMessage: 'failure'));
      await tester.pump();
      expect(find.text('failure'), findsOneWidget);
    });

    testWidgets('Test getFormattedResult()', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      final StatefulElement _searchBarElement =
          tester.element(find.byType(SearchBar));
      final SearchBarState _searchBarState =
          _searchBarElement.state as SearchBarState;

      final result = _searchBarState.getFormattedResult(
          keyword: 'ch', result: 'chicken chop');
      expect(
        result[0],
        TextSpan(
          text: 'ch',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
      expect(
        result[1],
        TextSpan(
          text: 'icken ',
        ),
      );
      expect(
        result[2],
        TextSpan(
          text: 'ch',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
      expect(
        result[3],
        TextSpan(
          text: 'op',
        ),
      );
    });

    testWidgets('Test listener to searchStreamSubscription',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      final StatefulElement _searchBarElement =
          tester.element(find.byType(SearchBar));
      final SearchBarState _searchBarState =
          _searchBarElement.state as SearchBarState;

      searchBloc.stream.listen((event) {});

      searchBloc.emit(KeywordSearchRecipeInProgress());
      await tester.pump();
      expect(_searchBarState.dropdownOverlayEntry, isNotNull);

      searchBloc.emit(SearchTextFieldChangeSuccess(recipeTextFieldValue: ''));
      await tester.pump();
      expect(_searchBarState.dropdownOverlayEntry, isNull);

      searchBloc.emit(KeywordSearchAutofillSuccess(autofillValue: 'chicken'));
      await tester.pump();
      expect(_searchBarState.dropdownOverlayEntry, isNull);
      expect(_searchBarState.searchTextEditingController.text, 'chicken');
      expect(
          _searchBarState.searchTextEditingController.selection,
          TextSelection.fromPosition(TextPosition(
              offset:
                  _searchBarState.searchTextEditingController.text.length)));
    });

    testWidgets('Test listener to searchFocusNode',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      final StatefulElement _searchBarElement =
          tester.element(find.byType(SearchBar));
      final SearchBarState _searchBarState =
          _searchBarElement.state as SearchBarState;

      _searchBarState.searchFocusNode.requestFocus();
      await tester.pump();
      expect(_searchBarState.searchHasFocus, true);

      _searchBarState.searchFocusNode.unfocus();
      await tester.pump();
      expect(_searchBarState.searchHasFocus, false);
      expect(_searchBarState.dropdownOverlayEntry, isNull);

      _searchBarState.searchTextEditingController.text = 'chicken';
      searchBloc.emit(KeywordSearchRecipeSuccess(recipes: [
        RecipeModel(name: 'chicken 1'),
      ]));
      _searchBarState.searchFocusNode.requestFocus();
      await tester.pump();
      expect(_searchBarState.dropdownOverlayEntry, isNotNull);
    });
  });
}
