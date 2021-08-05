import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_state.dart';
import 'package:mobile_app/src/screens/forgot_password_screen.dart';

void main() async {
  final widget = MaterialApp(
    home: MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ForgotPasswordBloc(),
      )
    ], child: ForgotPasswordScreen()),
  );
  group('Forgot password tablet', () {
    testWidgets('Forgot password show title', (tester) async {
      tester.binding.window.physicalSizeTestValue = Size(1000, 1500);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(widget);
      final title = find.text("Reset password");
      ForgotPasswordBloc().emit(ForgotPasswordInitial());
      await tester.pump();
      expect(title, findsOneWidget);
    });
  });
}
    
  //   testWidgets('Forgot password show label', (tester) async {
  //     tester.binding.window.physicalSizeTestValue = Size(1000, 1500);
  //     addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  //     await tester.pumpWidget(widget);
  //     final label = find.text(
  //         "Enter the email associated with your account and we'll send an email with a link to reset your password.");
  //     ForgotPasswordBloc().emit(ForgotPasswordInitial());
  //     await tester.pump();
  //     expect(label, findsOneWidget);
  //   });
  //   testWidgets('Forgot password show tablet label', (tester) async {
  //     tester.binding.window.physicalSizeTestValue = Size(1000, 1500);
  //     addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  //     await tester.pumpWidget(widget);
  //     final tabletLabel = find.text("Start from Scratch");
  //     ForgotPasswordBloc().emit(ForgotPasswordInitial());
  //     await tester.pump();
  //     expect(tabletLabel, findsOneWidget);
  //   });
  //   testWidgets('Should render logo with title', (tester) async {
  //     tester.binding.window.physicalSizeTestValue = Size(1000, 1500);
  //     addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  //     await tester.pumpWidget(widget);
  //     final logoFinder = find.byType(Logo);
  //     final albumTitleFinder =
  //         find.descendant(of: logoFinder, matching: find.text('Join Scratch'));
  //     ForgotPasswordBloc().emit(ForgotPasswordInitial());
  //     await tester.pump();
  //     expect(albumTitleFinder, findsOneWidget);
  //   });
  //   testWidgets('Forgot password show text button', (tester) async {
  //     tester.binding.window.physicalSizeTestValue = Size(1000, 1500);
  //     addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  //     await tester.pumpWidget(widget);
  //     final sendButton = find.text('Send');
  //     ForgotPasswordBloc().emit(ForgotPasswordInitial());
  //     await tester.pump();
  //     expect(sendButton, findsOneWidget);
  //   });

  //   testWidgets('Should Send button click', (tester) async {
  //     tester.binding.window.physicalSizeTestValue = Size(1000, 1500);
  //     addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  //     await tester.pumpWidget(widget);
  //     await tester.tap(find.byType(ElevatedButton));
  //     final navigateLoginPage = find.byType(LoginScreen);
  //     await tester.pump();
  //     // Expect to find the item on screen.
  //     expect(navigateLoginPage, findsOneWidget);
  //   });
  // });
  // group('Forgot password mobile', () {
  //   testWidgets('Should render logo with title', (tester) async {
  //     addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  //     await tester.pumpWidget(widget);
  //     final logoFinder = find.byType(Logo);
  //     final albumTitleFinder =
  //         find.descendant(of: logoFinder, matching: find.text('Join Scratch'));
  //     ForgotPasswordBloc().emit(ForgotPasswordInitial());
  //     await tester.pump();
  //     expect(albumTitleFinder, findsOneWidget);
  //   });
  // });

