import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';

String globalUser='';
String globalNumber='';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  final dio = Dio();

        var username = '';
        var nickname = '';
        var phone_number = '';
        var register_date = '';
  // 가상의 사용자 정보
  //final String username = "사용자명";
  //final String nickname = "닉네임";
  //final String phoneNumber = "전화번호";
  //final String registerDate = "등록일자";

  @override
  void initState() {
    super.initState();
    requestUserInfo(token);
  }

  Future<void> requestUserInfo(String token) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    try {
      Response response = await dio.get('http://ec2-13-209-75-120.ap-northeast-2.compute.amazonaws.com/users/info/');
      if (response.statusCode == 200) {
        print("Success: ${response.data}");
        var userInfo = response.data;
        username = userInfo['username'];
        globalUser=username;
         print("Success: $username");
        nickname = userInfo['nickname'];
        phone_number = userInfo['phone_number'];
        globalNumber=phone_number;
        register_date = userInfo['register_date'];
        // 이후 필요한 작업을 수행하실 수 있습니다.
      } else if (response.statusCode == 401) {
        print("Authentication Error: ${response.data}");
        // 인증 실패나 토큰 오류에 대한 처리를 여기에 추가하세요.
      }
    } catch (e) {
      print("Error: $e");
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("마이페이지"),
    ),
    backgroundColor: const Color.fromARGB(149, 51, 77, 143),
    body: Center(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(45),
            decoration: BoxDecoration(
              color: const Color.fromARGB(159, 255, 178, 178),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text("사용자명: $username", style: TextStyle(color: Colors.black)),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(45),
            decoration: BoxDecoration(
              color: const Color.fromARGB(159, 255, 178, 178),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text("닉네임: $nickname", style: TextStyle(color: Colors.black)),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(45),
            decoration: BoxDecoration(
              color: const Color.fromARGB(159, 255, 178, 178),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text("전화번호: $phone_number", style: TextStyle(color: Colors.black)),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(45),
            decoration: BoxDecoration(
              color: const Color.fromARGB(159, 255, 178, 178),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text("등록일자: $register_date", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    ),
  );
}
}
