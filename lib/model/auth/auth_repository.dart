import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/core/constants/my_dio.dart';
import 'package:flutter_riverpod_blog_start/dto/auth_request.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/user/user.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) =>
    AuthRepository());

class AuthRepository {

  Future<ResponseDTO> fetchJoin(JoinRequestDTO joinRequestDTO) async {
    // 요청시에는 map을 body에 담기 (dto가 json으로 변경해준다.)
    // 응답시에는 Response.data에 map을 담아줌 (dio가 json으로 변경해서 담아준다.)
    Response response = await dio.post("/join", data: joinRequestDTO.toJson());

    ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
    responseDTO.data = User.fromJson(responseDTO.data);

    return responseDTO;
  }

  Future<ResponseDTO> fetchLogin(LoginRequestDTO loginRequestDTO) async {

    // 1. 통신 시작
    Response response = await dio.post("/join", data: loginRequestDTO.toJson());

    // 2. DTO 파싱
    ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
    responseDTO.data = User.fromJson(responseDTO.data);

    // 3. 토큰 받기
    responseDTO.token = response.headers["authorization"].toString();
    return responseDTO;
  }

}