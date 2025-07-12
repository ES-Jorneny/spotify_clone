import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/auth/auth_repository.dart';

class ResetPasswordUseCase implements UseCase<Either,String>{
  @override
  Future<Either> call({String? params}) {
    return sl<AuthRepository>().resetPassword(params!);
  }


}