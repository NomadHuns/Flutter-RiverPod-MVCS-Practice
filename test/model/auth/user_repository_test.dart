
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/dto/user_request.dart';
import 'package:flutter_riverpod_blog_start/model/auth/user_repository.dart';
import 'package:flutter_riverpod_blog_start/model/user/user.dart';
import 'package:logger/logger.dart';

void main() async {
  await fetchLogin_test();
}

Future<void> fetchJoin_test() async{
  JoinRequestDTO joinRequestDTO = JoinRequestDTO(username: "babo12", password: "1234", email: "babo1@naver.com");
  ResponseDTO response = await UserRepository().fetchJoin(joinRequestDTO);
  Logger().d(response.msg);
  User user = response.data;
  Logger().d(user.username);
}

Future<void> fetchLogin_test() async{
  LoginRequestDTO loginRequestDTO = LoginRequestDTO(username: "babo12", password: "1234");
  ResponseDTO response = await UserRepository().fetchLogin(loginRequestDTO);
  Logger().d(response.msg);
  Logger().d("${response.token}");
  User user = response.data;
  Logger().d(user.username);
}