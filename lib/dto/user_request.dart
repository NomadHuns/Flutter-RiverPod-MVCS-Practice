import 'package:intl/intl.dart';

class JoinRequestDTO {
  final String username;
  final String password;
  final String email;


  JoinRequestDTO({
    required this.username,
    required this.password,
    required this.email,
  });

  // 통신을 위해서 json 처럼 생긴 문자열 {"id":1} => Dart 오브젝트
  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "email": email,
  };

  JoinRequestDTO.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        password = json["password"],
        email = json["email"];
}

class LoginRequestDTO {
  final String username;
  final String password;


  LoginRequestDTO({
    required this.username,
    required this.password,
  });

  // 통신을 위해서 json 처럼 생긴 문자열 {"id":1} => Dart 오브젝트
  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };

  LoginRequestDTO.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        password = json["password"];
}