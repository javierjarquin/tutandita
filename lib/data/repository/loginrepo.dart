import 'package:tutandita/domain/entities/user.dart';
import 'package:tutandita/domain/usecases/login.dart';

class Loginrepo implements LoginUseCase {
  @override
  Future<bool> execute(User user) async {
    if (user.email == 'admin' && user.password == 'admin') {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
