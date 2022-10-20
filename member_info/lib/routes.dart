import 'package:flutter/cupertino.dart';
import 'package:member_info/splash.dart';
import 'package:member_info/visibility.dart';
import 'member.dart';


//라우트(Route)란? 화면간 이동,
// Flutter 앱에서는 스크린이나 페이지를 라우트(Route)라고 부른다.
class Routes {
  Routes._();

  static String splash = '/splash';
  static String member = '/member';
  static String visibility = '/visibility';

  static final routes = <String, WidgetBuilder>{
    splash: (context) => SlpashScreen(),
    member: (context) => MemberPage(),
    visibility: (context) => ControlleApp(),

  };
}
