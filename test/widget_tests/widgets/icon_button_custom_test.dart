import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/post_bloc/post_bloc.dart';
import 'package:mobile_app/src/services/post_service.dart';
import 'package:mobile_app/src/widgets/icon_button_custom.dart';
import 'package:mockito/mockito.dart';

import '../../cloud_firestore_mock.dart';

class MockPostServices extends Mock implements PostServices {}

void main() {
  late PostBloc postBloc;
  late MockPostServices mockPostServices;
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });
  setUp(() {
    mockPostServices = MockPostServices();
    postBloc = PostBloc(postServices: mockPostServices);
  });

  final widget = ScreenUtilInit(
    builder: () => MaterialApp(
      home: BlocProvider(
        create: (context) => postBloc,
        child: Scaffold(
          body: IconButtonCustom(
            onTap: () {},
            icons: 'assets/images/icons/add.png',
          ),
        ),
      ),
    ),
  );

  testWidgets('Should render the icon button custom text',
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    expect(find.byType(InkWell), findsOneWidget);
  });
}
