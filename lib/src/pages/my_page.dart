import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';

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
         print("Success: $username");
        nickname = userInfo['nickname'];
        phone_number = userInfo['phone_number'];
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("사용자명: $username"),
            Text("닉네임: $nickname"),
            Text("전화번호: $phone_number"),
            Text("등록일자: $register_date"),
          ],
        ),
      ),
    );
  }
}
