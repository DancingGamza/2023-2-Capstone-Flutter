import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';
import 'package:flutter_sns_form/src/app.dart';


class MyProfilePage extends StatefulWidget {
  
  final String nickname;
  final String phoneNumber;
  final int profilenumber;
  final bool personalconsent;
  MyProfilePage({
    
    required this.nickname,
    required this.phoneNumber,
    required this.profilenumber,
    required this.personalconsent,
  });

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  
  TextEditingController nicknameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool sharePhoneNumber = false;
  int? profileNum = 1;

  @override
  void initState() {
    super.initState();
    
    nicknameController.text = widget.nickname;
    phoneNumberController.text = widget.phoneNumber;
    sharePhoneNumber = widget.personalconsent;
    profileNum=widget.profilenumber;
  }

  Future<void> fixinguser( newNickname, newPhoneNumber, profileNum,
      sharePhoneNumber) async {
    Dio dio = Dio();
    dio.options.headers = {'Authorization': 'Bearer $token'};
    dio.options.contentType = 'multipart/form-data';

    var formData = FormData.fromMap({
      
      'nickname':newNickname,
      'phone_number': newPhoneNumber,
      'profile_number': profileNum,
      'personal_consent': sharePhoneNumber,
    });

    try {
      Response response = await dio.put(
        'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/user/info',
        data: formData,
      );

      print(response);

      if (response.statusCode == 200) {
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('수정 완료'),
            content: Text('수정이 완료되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const App(),
          ),
        );
      }
    } catch (error) {
      print("$error 신고실패");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 정보 수정'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            _buildTextField('Nickname', nicknameController),
            _buildTextField('Phone Number', phoneNumberController),
            SizedBox(height: 16),
            // Profile picture selection
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                labelText: '프로필 사진 선택',
              ),
              value: profileNum,
              onChanged: (int? newValue) {
                setState(() {
                  profileNum = newValue;
                });
              },
              items: [
                DropdownMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Image.asset('assets/images/mydog1.png',
                          width: 30, height: 30),
                      SizedBox(width: 8),
                      Text('민트멍'),
                    ],
                  ),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Row(
                    children: [
                      Image.asset('assets/images/mydog2.png',
                          width: 30, height: 30),
                      SizedBox(width: 8),
                      Text('보라멍'),
                    ],
                  ),
                ),
                DropdownMenuItem<int>(
                  value: 3,
                  child: Row(
                    children: [
                      Image.asset('assets/images/mydog3.png',
                          width: 30, height: 30),
                      SizedBox(width: 8),
                      Text('하트멍'),
                    ],
                  ),
                ),
                DropdownMenuItem<int>(
                  value: 4,
                  child: Row(
                    children: [
                      Image.asset('assets/images/mydog4.png',
                          width: 30, height: 30),
                      SizedBox(width: 8),
                      Text('푸앙멍'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: sharePhoneNumber,
                  onChanged: (value) {
                    setState(() {
                      sharePhoneNumber = value!;
                    });
                  },
                ),
                Text('전화번호 공개 동의'),
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 수정된 정보를 처리하는 로직 추가
                  
                  String newNickname = nicknameController.text.isNotEmpty
                      ? nicknameController.text
                      : widget.nickname;
                  String newPhoneNumber = phoneNumberController.text.isNotEmpty
                      ? phoneNumberController.text
                      : widget.phoneNumber;

                  fixinguser(newNickname, newPhoneNumber,
                      profileNum, sharePhoneNumber);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(
                      255, 111, 174, 186), // Change the button color here
                ),
                child: Text('수정'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: controller,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
