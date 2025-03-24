import 'package:tutandita/domain/entities/user.dart';

abstract class LoginUseCase {
  Future<bool> execute(User user);
}
