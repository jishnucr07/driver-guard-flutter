// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String uuid;
  final String uname;
  final String image;
  final String password;
  final String email;

  UserModel({
    required this.uuid,
    required this.uname,
    required this.image,
    required this.password,
    required this.email,
  });

  UserModel copyWith({
    String? uuid,
    String? uname,
    String? image,
    String? password,
    String? email,
  }) {
    return UserModel(
      uuid: uuid ?? this.uuid,
      uname: uname ?? this.uname,
      image: image ?? this.image,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'uname': uname,
      'image': image,
      'password': password,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uuid: map['uuid'] as String,
      uname: map['uname'] as String,
      image: map['image'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uuid: $uuid, uname: $uname, image: $image, password: $password, email: $email)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uuid == uuid &&
        other.uname == uname &&
        other.image == image &&
        other.password == password &&
        other.email == email;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        uname.hashCode ^
        image.hashCode ^
        password.hashCode ^
        email.hashCode;
  }
}
