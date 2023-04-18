import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/core/constants/move.dart';
import 'package:flutter_riverpod_blog_start/core/constants/my_dio.dart';
import 'package:flutter_riverpod_blog_start/dto/user_request.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/main.dart';
import 'package:flutter_riverpod_blog_start/model/auth/user_repository.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';

final userControllerProvider = Provider((ref) => UserController(ref));

class UserController {

  // 현재 페이지의 Context를 갖고오기
  final mContext = navigatorKey.currentContext;

  // Repository, ViewModel 의존성 주입을 위해서 Ref 객체가 필요하다.
  final Ref ref;
  UserController(this.ref);

  Future<void> join(String username, String password, String email) async {
    JoinRequestDTO joinRequestDTO = JoinRequestDTO(username: username, password: password, email: email);
    // ref에서 Repository를 가져와서 메소드를 호출한다.
    ResponseDTO responseDTO = await UserRepository().fetchJoin(joinRequestDTO);

    // 결과값 확인하기
    if(responseDTO.code == 1) {
      // 네비게이터를 통해서 다음 화면으로 넘어간다.
      Navigator.pushNamed(mContext!, Move.loginPage);
    } else {
      // 실패 코드들은 여기서 예외 처리한다.
      final snackBar = SnackBar(content: Text("회원가입 실패"));
      ScaffoldMessenger.of(mContext!).showSnackBar(snackBar);
    }
  }

  Future<void> login(String username, String password) async {
    LoginRequestDTO loginRequestDTO = LoginRequestDTO(username: username, password: password);
    ResponseDTO responseDTO = await UserRepository().fetchLogin(loginRequestDTO);
    if(responseDTO.code == 1) {
      // 1. 토큰을 휴대폰에 저장
      secureStorage.write(key: "jwt", value: responseDTO.token);

      // 2, 로그인 상태 등록
      ref.read(sessionProvider).loginSuccess(responseDTO.data, responseDTO.token!);
      
      // 2. 화면 이동 (스택에 저장할 필요가 없는 경우 popAndPush한다.)
      Navigator.popAndPushNamed(mContext!, Move.postHomePage);
    } else {
      final snackBar = SnackBar(content: Text("로그인 실패"));
      ScaffoldMessenger.of(mContext!).showSnackBar(snackBar);
    }
  }
}