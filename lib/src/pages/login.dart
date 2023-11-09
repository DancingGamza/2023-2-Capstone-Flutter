import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart'; 
import 'package:flutter_sns_form/src/app.dart';
import 'package:flutter_sns_form/src/pages/signing_up.dart';
var token='';
String globalToken = '';

//void main() {
  //runApp(FigmaToCodeApp());
//}





class LogingIn extends StatefulWidget {
  LogingIn({super.key});

  @override
  _LogingInState createState() => _LogingInState();
}

class _LogingInState extends State<LogingIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
 
  String loginMessage = '';

  Future<void> loginUser(username, password) async {
    Dio dio= Dio();
    dio.options.contentType='multipart/form-data';

  var formData = FormData.fromMap({
      'username': username.toString(),
      'password': password.toString(),
  }); 
    Response response= await dio.post('http://ec2-13-209-75-120.ap-northeast-2.compute.amazonaws.com/users/login/',
      data : formData);
    print("lllll");
    print(response);

    if (response.statusCode == 200) {
      setState(() {
        globalToken = response.data['token'];
        token = response.data['token']; // Replace with the actual JSON key for the token
        //AppGlobals().setAuthToken(token);
        //loginMessage = "로그인 성공이요";
        loginMessage = token;
          Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const App(),
    ),
  );},);}
     
    else {
      //final Map<String, dynamic> error = json.decode(response.body);
  //print('Error Message: ${error['message']}');
      setState(() {
        loginMessage = "로그인 실패";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            loginarea(context),
            /*
            ElevatedButton(
              onPressed: () {
                print("버튼눌림");
                
                loginUser(emailController.text, passwordController.text);
                print("위에거");
              },
              child: Text('Log in'),
            ),*/
            Text(loginMessage, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

  Widget loginarea(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 375,
          height: 812,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFF334D8F)),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 200,
                child: Container(
                  width: 376,
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 50,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              child: Stack(children: [
                                // Email icon or content
                              ]),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 71,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ID',
                                          style: TextStyle(
                                            color: Color(0xFF474A56),
                                            fontSize: 14,
                                            fontFamily: 'Mazzard',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          height: 49,
                                          padding: const EdgeInsets.all(15),
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(width: 1, color: Color(0xFFC8D1E1)),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
                                          child: TextFormField( // Email input field
                                            controller: emailController,
                                            style: TextStyle(
                                              color: Color(0xFFC8D1E1),
                                              fontSize: 14,
                                              fontFamily: 'Mazzard',
                                              fontWeight: FontWeight.w400,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your ID',
                                              hintStyle: TextStyle(
                                                color: Color(0xFFC8D1E1),
                                                fontSize: 14,
                                                fontFamily: 'Mazzard',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 71,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Password',
                                                style: TextStyle(
                                                  color: Color(0xFF474A56),
                                                  fontSize: 14,
                                                  fontFamily: 'Mazzard',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Container(
                                                height: 49,
                                                padding: const EdgeInsets.all(15),
                                                decoration: ShapeDecoration(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(width: 1, color: Color(0xFFC8D1E1)),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                ),
                                                child: TextFormField( // Password input field
                                                  controller: passwordController,
                                                  obscureText: true, // Hide the entered text (for passwords)
                                                  style: TextStyle(
                                                    color: Color(0xFFC8D1E1),
                                                    fontSize: 14,
                                                    fontFamily: 'Mazzard',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Insert password',
                                                    hintStyle: TextStyle(
                                                      color: Color(0xFFC8D1E1),
                                                      fontSize: 14,
                                                      fontFamily: 'Mazzard',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 78),
                      Container(
                        height: 87,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //GestureDetector(
                              InkWell(
  onTap: () {
    Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => SigningUp(),
    ),
  );
    //SigningUp();
    print("눌림ㅁㅁㅁ");
    // "Sign up" 텍스트를 클릭할 때 수행할 작업을 처리하세요.
    // 예를 들어, 회원 가입 페이지로 이동하거나 다른 작업을 수행할 수 있습니다.
  },
  child: Text(
    'Don’t you have an account? Sign up',
    style: TextStyle(
      color: Colors.black, // 텍스트를 투명하게 만듭니다.
      fontSize: 16,
      fontFamily: 'Mazzard',
      fontWeight: FontWeight.w500,
      height: 0,
    ),
  ),),
//),

                            const SizedBox(height: 18),
                            Container(
                              width: double.infinity,
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              decoration: ShapeDecoration(
                                color: Color(0xFF334D8F),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      print("버튼눌림");
                                      loginUser(emailController.text, passwordController.text);
                                      print("위에거");
                                      },
                                    child: 
                                      Text(
                                        'Log in',
                                        style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Mazzard',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                        ),
                                      ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 117,
                child: SizedBox(
                  width: 335,
                  child: Text(
                    '로그인 페이지',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Mazzard',
                      fontWeight: FontWeight.w500,
                      height: 0.07,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 796,
                child: Container(
                  height: 34,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 414,
                        height: 34,
                        padding: const EdgeInsets.only(
                          top: 21,
                          left: 134,
                          right: 134,
                          bottom: 8,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 146,
                              height: 5,
                              decoration: ShapeDecoration(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: -1,
                top: 0,
                child: Container(
                  width: 375,
                  height: 50.49,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 78,
                        top: -2,
                        child: Container(
                          width: 219,
                          height: 30,
                          child: Stack(children: [
                            // Place any content for this section here
                          ]),
                        ),
                      ),
                      Positioned(
                        left: 293.67,
                        top: 8,
                        child: Container(
                          width: 66.66,
                          height: 20.67,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 42.33,
                                top: 9.33,
                                child: Container(
                                  width: 24.33,
                                  height: 11.33,
                                  child: Stack(children: [
                                    // Place any content for this section here
                                  ]),
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 7,
                        top: 12,
                        child: Container(
                          width: 54,
                          height: 21,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Place any content for this section here
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
