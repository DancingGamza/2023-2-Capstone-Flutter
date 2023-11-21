import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/app.dart';
import 'package:flutter_sns_form/src/pages/login.dart';

//var token='';

//void main() {
//runApp(SigningUp());
//}

class SigningUp extends StatefulWidget {
  SigningUp({super.key});

  @override
  _SigningUpState createState() => _SigningUpState();
}

class _SigningUpState extends State<SigningUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController pwagainController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  String signupMessage = '';

  Future<void> signupUser(
      username, nickname, password, pwagain, phonenumber) async {
    Dio dio = Dio();
    dio.options.contentType = 'multipart/form-data';

    var formData = FormData.fromMap({
      'username': username.toString(),
      'nickname': nickname.toString(),
      'password1': password.toString(),
      'password2': pwagain.toString(),
      'phone_number': phonenumber.toString()
    });
    Response response;
    try {
      Response response = await dio
          .post(
              'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/users/signup/',
              data: formData)
          .catchError((onError) {
        print("회원가입실패");
        setState(() {
          signupMessage = "회원가입 실패!!";
        });
      });
    } catch (e) {
      print(e);
      print("aaaaaaaaaaaaaaa");
    }
    print("bbbbbbbbbbbbbbbb");
    response = await dio.post(
        'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/users/signup/',
        data: formData);

    print("lllll");
    print(response);

    if (response.statusCode == 200) {
      setState(
        () {
          signupMessage = "회원가입 성공";
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LogingIn(),
            ),
          );
        },
      );
    }

    /*
     if (response.statusCode == 400) {
      setState(() {
        print("400들어옴");
        final Map<String, dynamic> error = response.data;
      print('Error Message: ${error['message']}');
        signupMessage="회원가입 실패";
  },);}*/

    else {
      print("lksajflsadlkghdlgdhkl1");
      setState(() {
        print("else들어옴");
        final Map<String, dynamic> error = response.data;
        print('Error Message: ${error['message']}');
        signupMessage = "회원가입 실패";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 111, 174, 186),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            signuparea(context),
            /*
            ElevatedButton(
              onPressed: () {
                print("버튼눌림");
                
                loginUser(emailController.text, passwordController.text);
                print("위에거");
              },
              child: Text('Log in'),
            ),*/
            Text(signupMessage, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

  Widget signuparea(BuildContext context) {
    return Column(children: [
      Container(
        width: 375,
        height: 812,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color.fromARGB(255, 111, 174, 186)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ID',
                                          style: TextStyle(
                                            color: Color(0xFF474A56),
                                            fontSize: 14,
                                            fontFamily: 'DungGeunMo',
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
                                              side: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFC8D1E1)),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                          child: TextFormField(
                                            // Email input field
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
                                  //const SizedBox(height: 30),
                                  const SizedBox(height: 20),
                                  Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 71,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Name',
                                                style: TextStyle(
                                                  color: Color(0xFF474A56),
                                                  fontSize: 14,
                                                  fontFamily: 'DungGeunMo',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Container(
                                                height: 49,
                                                padding:
                                                    const EdgeInsets.all(15),
                                                decoration: ShapeDecoration(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 1,
                                                        color:
                                                            Color(0xFFC8D1E1)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                ),
                                                child: TextFormField(
                                                  // Email input field
                                                  controller:
                                                      nicknameController,
                                                  style: TextStyle(
                                                    color: Color(0xFFC8D1E1),
                                                    fontSize: 14,
                                                    fontFamily: 'Mazzard',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Enter your name',
                                                    hintStyle: TextStyle(
                                                      color: Color(0xFFC8D1E1),
                                                      fontSize: 14,
                                                      fontFamily: 'Mazzard',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 71,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Password',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF474A56),
                                                        fontSize: 14,
                                                        fontFamily: 'DungGeunMo',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Container(
                                                      height: 49,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      decoration:
                                                          ShapeDecoration(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              width: 1,
                                                              color: Color(
                                                                  0xFFC8D1E1)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                      ),
                                                      child: TextFormField(
                                                        // Password input field
                                                        controller:
                                                            passwordController,
                                                        obscureText:
                                                            true, // Hide the entered text (for passwords)
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFC8D1E1),
                                                          fontSize: 14,
                                                          fontFamily: 'Mazzard',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'Insert password',
                                                          hintStyle: TextStyle(
                                                            color: Color(
                                                                0xFFC8D1E1),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Mazzard',
                                                            fontWeight:
                                                                FontWeight.w400,
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
                                        const SizedBox(height: 10),
                                        Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 71,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Password Again',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF474A56),
                                                        fontSize: 14,
                                                        fontFamily: 'DungGeunMo',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Container(
                                                      height: 49,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      decoration:
                                                          ShapeDecoration(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              width: 1,
                                                              color: Color(
                                                                  0xFFC8D1E1)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                      ),
                                                      child: TextFormField(
                                                        // Password input field
                                                        controller:
                                                            pwagainController,
                                                        obscureText:
                                                            true, // Hide the entered text (for passwords)
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFC8D1E1),
                                                          fontSize: 14,
                                                          fontFamily: 'Mazzard',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'Insert password again',
                                                          hintStyle: TextStyle(
                                                            color: Color(
                                                                0xFFC8D1E1),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Mazzard',
                                                            fontWeight:
                                                                FontWeight.w400,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Phone number',
                                          style: TextStyle(
                                            color: Color(0xFF474A56),
                                            fontSize: 14,
                                            fontFamily: 'DungGeunMo',
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
                                              side: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFC8D1E1)),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                          child: TextFormField(
                                            // Phone number input field
                                            controller: phonenumberController,
                                            //obscureText: true, // Hide the entered text (for phone numbers)
                                            style: TextStyle(
                                              color: Color(0xFFC8D1E1),
                                              fontSize: 14,
                                              fontFamily: 'Mazzard',
                                              fontWeight: FontWeight.w400,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Insert phone number',
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
                                  Container(
                                    height: 87,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LogingIn(),
                                              ),
                                            );

                                            print("눌림ㅁㅁㅁ");
                                          },
                                          child: Text(
                                            'Already have an account? Log in',
                                            style: TextStyle(
                                              color: Colors
                                                  .black, // 텍스트를 투명하게 만듭니다.
                                              fontSize: 16,
                                              fontFamily: 'DungGeunMo',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 18),
                                        GestureDetector(
  onTap: () {
    print("Container가 눌림");
    signupUser(
      emailController.text,
      nicknameController.text,
      passwordController.text,
      pwagainController.text,
      phonenumberController.text,
    );
    print("위에거");
  },
  child: Container(
    width: double.infinity,
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    decoration: ShapeDecoration(
      color: Color.fromARGB(255, 111, 174, 186),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Sign up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'DungGeunMo',
            fontWeight: FontWeight.w500,
            height: 0,
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
                              ),
                            ),
                          ]),
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
                  '회원가입 페이지',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'DungGeunMo',
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
      )
    ]);
  }
}
