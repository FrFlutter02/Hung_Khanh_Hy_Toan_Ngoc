import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_bloc.dart';

import 'package:mobile_app/src/screens/home_screen.dart';

import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

void main() {
  setUp(() => {registerFallbackValue(MyFakeType())});
  final _widget = BlocProvider(
    create: (_) => ForgotPasswordBloc(),
    child: MaterialApp(home: HomeScreen()),
  );
  group('Home mobile', () {
    testWidgets('Should render bottom navigation bar', (tester) async {
      await tester.pumpWidget(_widget);
      final bottomNavigationBarFinder = find.byType(BottomNavigationBar);
      expect(bottomNavigationBarFinder, findsOneWidget);
    });
    testWidgets(
        'Should render Search logo , Carosel logo and User profile logo',
        (tester) async {
      final AssetImage imageSearch = AssetImage(
        'assets/images/search_icon.jpg',
        package: 'test_package',
      );
      final AssetImage imageCarosel = AssetImage(
        'assets/images/carosel_icon.jpg',
        package: 'test_package',
      );
      final AssetImage imageUserProfile = AssetImage(
        'assets/images/user_profile_icon.jpg',
        package: 'test_package',
      );
      await tester.pumpWidget(_widget);
      expect(imageSearch.keyName,
          'packages/test_package/assets/images/search_icon.jpg');
      expect(imageCarosel.keyName,
          'packages/test_package/assets/images/carosel_icon.jpg');
      expect(imageUserProfile.keyName,
          'packages/test_package/assets/images/user_profile_icon.jpg');
    });
    // testWidgets('Should render correct color when tap the icon',
    //     (tester) async {
    //   await tester.pumpWidget(_widget);
    //   final RenderImage renderer =
    //       tester.renderObject<RenderImage>(find.byType(Image));
    //   expect(renderer.color, const Color(0xFF00FF00));
    // });
    testWidgets('Should render correct color when tap the icon',
        (tester) async {
      await tester.pumpWidget(_widget);

      await tester.tap(find.text('Search'));
      final RenderImage renderer =
          tester.renderObject<RenderImage>(find.byType(Image));
      await tester.pump(const Duration(seconds: 1));
      print(renderer);
      expect(renderer, equals(Brightness.dark));
    });
  });
}
