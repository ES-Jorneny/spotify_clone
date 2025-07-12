import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/domain/entities/auth/user_entity.dart';

import '../../models/auth/user_model.dart';

abstract class AuthServices {
  Future<Either> signUp(UserModel user);

  Future<Either> signIn(UserModel user);

  Future<bool> isUserLoggedIn();

  Future<void> logOut();

  Future<Either> resetPassword(String email);

  Future<Either> getUser();



}

class AuthServiceImplementation extends AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> logOut() async {
    await _auth.signOut();
  }

  @override
  Future<Either> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Right("Reset email sent successfully.");
    } on FirebaseAuthException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either> signIn(UserModel user) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      return Right("Sign In Was Successful");
    } on FirebaseAuthException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either> signUp(UserModel user) async {
    try {
      var data = await _auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      FirebaseFirestore.instance
          .collection("users")
          .doc(data.user!.uid) // 👈 Use UID as document ID
          .set({
            "uid": data.user!.uid,
            "name": user.username,
            "email": data.user!.email,
          });

      return Right("Sign Up Was Successful");
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return Left(e.message);
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    final user = _auth.currentUser;
    return user != null;
  }

  @override
  Future<Either> getUser() async {
    try {
      var user = await FirebaseFirestore.instance
          .collection("users")
          .doc(_auth.currentUser?.uid)
          .get();
      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageUrl = _auth.currentUser?.photoURL ?? "";
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      return Left("An error occurred");
    }
  }


}
