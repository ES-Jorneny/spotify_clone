import 'package:spotify_clone/domain/entities/auth/user_entity.dart';

class UserModel {
String? username;
String? email;
String? password;
   String? imageUrl;
   String? publicId;

  UserModel({this.username, required this.email, this.password,this.imageUrl,this.publicId});
  UserModel.fromJson(Map<String, dynamic> data) {
    username = data["name"];
    imageUrl = data["imageUrl"];
    publicId = data["publicId"];
    email = data["email"];
  }
}
extension UserModelX on UserModel{
  UserEntity toEntity() {
    return UserEntity(
        username: username,
      email: email,
      publicId: publicId,
      imageUrl: imageUrl

    );
  }
}