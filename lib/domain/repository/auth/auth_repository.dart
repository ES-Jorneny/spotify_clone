import 'package:dartz/dartz.dart';

import 'package:spotify_clone/data/models/auth/user_model.dart';

abstract class AuthRepository{
  Future<Either> signUp(UserModel user);
  Future<Either> signIn(UserModel user);
  Future<bool> isUserLoggedIn();
  Future<void> logOut();
  Future<Either> resetPassword(String email);
  Future<Either> getUer();

}