import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_ingredients.dart';
import 'package:mocktail/mocktail.dart';

import '../../../cloud_firestore_mock.dart';

class FakeRoute extends Fake implements Route {}

class MockUserServices extends Mock implements UserServices {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  final mockUserServices = MockUserServices();
  final _newRecipeBloc = NewRecipeBloc(userServices: mockUserServices);
  final _widget = BlocProvider(
      create: (_) => _newRecipeBloc,
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          home: ItemNewIngredients(),
        ),
      ));
}
