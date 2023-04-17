
class ResponseDTO {
  final int? code;
  final String? msg;
  String? token;
  dynamic data; // JsonArray [], JsonObject {}
  // 어떤 타입으로 올 지 모르기 때문에 dynamic으로 받는다.
  // Map형태로 들어오기 때문에 파싱을 하여 객체로 만드는 것이 좋다.

  ResponseDTO({
    this.code,
    this.msg,
    this.token,
    this.data,
  });

  ResponseDTO.fromJson(Map<String, dynamic> json)
      : code = json["code"],
        msg = json["msg"],
        token = json["token"],
        data = json["data"];
}