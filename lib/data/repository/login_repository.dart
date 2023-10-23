import '../api/api_exports.dart';
import '../model/model_exports.dart';

class LoginRepository {
  final _provider = LoginApiProvider();
  Future<Success> loginVendor(
      {required String email, required String password}) {
    return _provider.login(email: email, password: password);
  }
}
