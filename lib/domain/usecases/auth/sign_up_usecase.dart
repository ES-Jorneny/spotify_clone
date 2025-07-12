import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/data/models/auth/user_model.dart';
import 'package:spotify_clone/domain/repository/auth/auth_repository.dart';

import '../../../service_locator.dart';


class SignUpUseCase implements UseCase<Either,UserModel>{
  @override
  Future<Either> call({UserModel? params}) {
    return sl<AuthRepository>().signUp(params!);
  }


}