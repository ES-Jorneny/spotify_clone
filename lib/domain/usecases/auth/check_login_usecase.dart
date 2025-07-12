import '../../../core/usecase/no_params.dart';
import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/auth/auth_repository.dart';

class CheckLoginUseCase implements UseCase<bool, NoParams> {
  @override
  Future<bool> call({NoParams? params}) async {
   return await sl<AuthRepository>().isUserLoggedIn();
  }
}