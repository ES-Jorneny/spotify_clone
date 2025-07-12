import '../../../core/usecase/no_params.dart';
import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/auth/auth_repository.dart';

class LogOutUseCase implements UseCase<void, NoParams> {
  @override
  Future<void> call({NoParams? params}) async {
    await sl<AuthRepository>().logOut();
  }
}