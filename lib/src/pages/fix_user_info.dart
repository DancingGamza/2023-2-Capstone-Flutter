import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyProfilePage(
        username: "user123",
        nickname: "JohnDoe",
        phoneNumber: "123-456-7890",
      ),
    );
  }
}

class MyProfilePage extends StatefulWidget {
  final String username;
  final String nickname;
  final String phoneNumber;

  MyProfilePage({
    required this.username,
    required this.nickname,
    required this.phoneNumber,
  });

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool sharePhoneNumber = false;

  @override
  void initState() {
    super.initState();
    usernameController.text = widget.username;
    nicknameController.text = widget.nickname;
    phoneNumberController.text = widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 정보 수정'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Username', usernameController),
            _buildTextField('Nickname', nicknameController),
            _buildTextField('Password', passwordController, isPassword: true),
            _buildTextField('Phone Number', phoneNumberController),
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
                Text('전화번호 공개에 동의합니다.'),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 수정된 정보를 처리하는 로직 추가
                String newUsername =
                    usernameController.text.isNotEmpty ? usernameController.text : widget.username;
                String newNickname =
                    nicknameController.text.isNotEmpty ? nicknameController.text : widget.nickname;
                String newPassword = passwordController.text.trim().isNotEmpty
                    ? passwordController.text
                    : '***'; // 변경된 경우에만 새로운 비밀번호로, 아니면 기존 비밀번호 마스킹
                String newPhoneNumber = phoneNumberController.text.isNotEmpty
                    ? phoneNumberController.text
                    : widget.phoneNumber;

                if (newPassword.trim().isEmpty) {
                  // 비밀번호가 공백인 경우 아무 작업도 하지 않음
                  return;
                }

                // TODO: 수정된 정보를 처리하는 로직 추가
                print('수정된 정보:');
                print('Username: $newUsername');
                print('Nickname: $newNickname');
                print('Password: $newPassword');
                print('Phone Number: $newPhoneNumber');
                print('전화번호 공개 동의: $sharePhoneNumber');
              },
              child: Text('수정'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: controller,
          obscureText: isPassword,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
