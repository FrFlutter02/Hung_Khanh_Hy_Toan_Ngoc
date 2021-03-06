import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/keyword_search_bloc/keyword_search_bloc.dart';
import 'package:mobile_app/src/screens/search_screen.dart';
import 'package:mobile_app/src/services/search_services.dart';
import 'package:mobile_app/src/widgets/search/search_bar.dart';
import 'package:mockito/mockito.dart';

import '../../cloud_firestore_mock.dart';

class MockSearchServices extends Mock implements SearchServices {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  final mockSearchServices = MockSearchServices();
  final Widget _widget = BlocProvider(
      create: (_) => KeywordSearchBloc(searchServices: mockSearchServices),
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          home: SearchScreen(),
        ),
      ));

  testWidgets('Should render Dividers on tablet screen',
      (WidgetTester tester) async {
    Device.width = 1920;
    Device.height = 1920;
    Device.devicePixelRatio = 2;
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    await tester.pumpWidget(_widget);
    expect(
        find.descendant(
            of: find.byType(ListView), matching: find.byType(Divider)),
        findsNWidgets(2));
  });

  testWidgets('Should render a SearchBox', (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    expect(find.byType(SearchBar), findsOneWidget);
  });
}
