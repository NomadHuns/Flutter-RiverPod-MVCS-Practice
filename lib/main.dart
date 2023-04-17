import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/core/constants/move.dart';
import 'package:flutter_riverpod_blog_start/core/constants/my_dio.dart';

// 현재 Context를 불러오기 위해서 사용
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // MyApp 시작 전에 필요한 것 여기서 다 로딩
  WidgetsFlutterBinding.ensureInitialized();
  // 0. 로딩화면 출력

  // 1. 시큐어 스토리지에 JWT 있는지 확인
  await secureStorage.read(key: "jwt");
  // 2. JWT를 가지고 회원정보를 가져온다.

  // 3. SessionUser 동기화 (JWT에 접근해야함)

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: Move.loginPage,
      routes: getRouters(),
    );
  }
}