import 'package:dartz/dartz.dart';

import 'package:spotify_clone/data/models/auth/user_model.dart';
import 'package:spotify_clone/data/sources/auth/auth_services.dart';
import 'package:spotify_clone/domain/repository/auth/auth_repository.dart';

import '../../../service_locator.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<void> logOut() async {
    await sl<AuthServices>().logOut();
  }

  @override
  Future<Either> resetPassword(String email) async{
    return await sl<AuthServices>().resetPassword(email);
  }

  @override
  Future<Either> signIn(UserModel user) async {
    return await sl<AuthServices>().signIn(user);
  }

  @override
  Future<Either> signUp(UserModel user) async{
  return await sl<AuthServices>().signUp(user);
  }

  @override
  Future<bool> isUserLoggedIn()async {
    return await sl<AuthServices>().isUserLoggedIn();
  }

  @override
  Future<Either> getUer() async {
    return await sl<AuthServices>().getUser();
  }



}