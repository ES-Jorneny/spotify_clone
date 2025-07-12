
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/models/auth/user_model.dart';
import '../../../service_locator.dart';
import '../../repository/auth/auth_repository.dart';

class SignInUseCase implements UseCase<Either,UserModel>{
  @override
  Future<Either> call({UserModel? params}) {
    return sl<AuthRepository>().signIn(params!);
  }


}