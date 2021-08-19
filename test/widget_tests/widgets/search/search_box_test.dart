import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/search_bloc/search_bloc.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/screens/search_screen.dart';
import 'package:mobile_app/src/services/search_services.dart';
import 'package:mockito/mockito.dart';

import '../../../cloud_firestore_mock.dart';

class MockSearchServices extends Mock implements SearchServices {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  final mockSearchServices = MockSearchServices();
  final Widget _widget = BlocProvider(
      create: (_) => SearchBloc(searchServices: mockSearchServices),
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          home: Searchscreen(),
        ),
      ));

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
}
