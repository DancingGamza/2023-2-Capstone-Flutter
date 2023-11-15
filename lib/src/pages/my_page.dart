import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:flutter_sns_form/src/pages/login.dart';

String globalUser = '';
String globalNumber = '';

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
        globalUser = username;
        print("Success: $username");
        nickname = userInfo['nickname'];
        phone_number = userInfo['phone_number'];
        globalNumber = phone_number;
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
        elevation: 0,
        centerTitle: true,
        title: ImageData(IconsPath.upmine, width: 400),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildInfoCard("ID: $username", 'assets/images/mybar4.jpg'),
            _buildInfoCard("이름: $nickname", 'assets/images/mybar4.jpg'),
            _buildInfoCard("전화번호: $phone_number", 'assets/images/mybar4.jpg'),
            _buildInfoCard("등록일자: $register_date", 'assets/images/mybar4.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String text, String imagePath) {
  return Card(
    margin: EdgeInsets.all(10),
    color: const Color.fromARGB(159, 255, 178, 178),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: SizedBox(
      height: 80, // Set your desired height for the card
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}
