import 'package:mobile_app/src/models/user_model.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mockito/mockito.dart';

class MockUserServices extends Mock implements UserServices {
  final mockUser = UserModel(
      fullName: '',
      avatar:
          'https://img.hoidap247.com/picture/question/20200718/large_1595063159202.jpg',
      email: '');
  Future<List<UserModel>> getUserData(String email) async {
    return [mockUser];
  }
}
