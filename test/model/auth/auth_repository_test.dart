import 'package:dio/dio.dart';
import 'package:flutter_riverpod_blog_start/dto/auth_request.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/user/user.dart';

final dio = Dio(BaseOptions(
    baseUrl: "http://192.168.200.41:8080",
    contentType: "application/json; charset=utf-8"));

void main() async {
  await fetchLogin_test();
}

Future<void> fetchJoin_test() async {

  // given
  String username = "hhfdftgghho";
  String password = "1234";
  String email = "hohoho@nate.com";

  Map<String, dynamic> requestBody = {
    "username": username,
    "password": password,
    "email": email
  };

  // 요청시에는 map을 body에 담기 (dto가 json으로 변경해준다.)
  // 응답시에는 Response.data에 map을 담아줌 (dio가 json으로 변경해서 담아준다.)
  Response response = await dio.post("/join", data: requestBody);
  print(response.data);

  ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
  print(responseDTO.code);
  print(responseDTO.msg);
  print(responseDTO.data);

  User user = User.fromJson(responseDTO.data);
  print(user.id);
  print(user.username);
  print(user.email);

  responseDTO.data = User.fromJson(responseDTO.data);

}

Future<void> fetchLogin_test() async {
  // given
  String username = "ssar";
  String password = "1234";

  // when
  Map<String, dynamic> requestBody = {
    "username":username,
    "password":password
  };

  // 1. 통신 시작
  Response response = await dio.post("/login", data: requestBody);

  // 2. DTO 파싱
  ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
  responseDTO.data = User.fromJson(responseDTO.data);

  // 3. 토큰 받기
  responseDTO.token = response.headers["authorization"].toString();

  print(responseDTO.code);
  print(responseDTO.msg);
  print(responseDTO.token);
  User user = responseDTO.data;
  print(user.id);
  print(user.username);
}
