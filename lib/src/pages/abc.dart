import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/app.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';
// void main() {
//   runApp(const Abc());
// }

// class Abc extends StatelessWidget {
//   const Abc({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.light().copyWith(
//         scaffoldBackgroundColor: Color.fromARGB(255, 111, 174, 186),
//       ),
//       home: Scaffold(
//         body: ListView(children: [
//           Jebo(),
//         ]),
//       ),
//     );
//   }
// }

class Jebo extends StatefulWidget {
  final int animalId;
  final String animalNickname;
  final String? animalFeatures;
  final String animalImageUrl;

  Jebo({
    required this.animalId,
    required this.animalNickname,
    required this.animalFeatures,
    required this.animalImageUrl,
    
  });

  @override
  _JeboState createState() => _JeboState();
}

class _JeboState extends State<Jebo> {
  
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController discoveryLocationController = TextEditingController();
  

  Future<void> _jeboPet() async {

    print("제보 들어옴요");



        Dio dio = Dio();
    dio.options.headers = {'Authorization': 'Bearer $token'};
    dio.options.contentType = 'multipart/form-data';

    var formData = FormData.fromMap({
      'animal_id':widget.animalId.toString(),
      'find_location':discoveryLocationController.text,
      'find_phone_number':phoneNumberController.text,
    });

    try {
      print("try들어옴요");
      Response response = await dio.post(
        'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/animal/find',
        data: formData,
      );

    print("gap");


      if (response.statusCode == 201 ||response.statusCode == 200) {
        print("제보됨");
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('제보 완료'),
            content: Text('제보가 완료되었습니다.'),
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
        // Display a success message
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text('Pet details updated successfully!'),
        // ));

        // // Navigate to the App() page
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => const App(),
        //   ),
        // );
      } else {
        // Handle the error
        print('Failed to jebo pet. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle the exception
      print('Error jebo pet details: $error');
    }
  }















  @override
  Widget build(BuildContext context) {
    print("갸아아아악");
    print('Animal Features: ${widget.animalFeatures}');
    print('Animal Nickname: ${widget.animalNickname}');
    print('Animal Nickname: ${widget.animalImageUrl}');
    print("갸아아아악");
    return SingleChildScrollView( // Wrap with SingleChildScrollView
      physics: BouncingScrollPhysics(), // Optional: Bounce effect on over-scrolling
      child: Column(
        children: [
          Container(
            width: 375,
            height: 812,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color.fromARGB(255, 111, 174, 186)),
            child: Stack(
              children: [
              Positioned(
  left: 93,
  top: 50,
  child: Container(
    width: 189,
    height: 184,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage('http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/media/${widget.animalImageUrl}'),
        fit: BoxFit.fill,
      ),
    ),
  ),
),
              Positioned(
                left: -1,
                top: 255,
                child: Container(
                  width: 376,
                  height: 513,
                  decoration: BoxDecoration(color: Colors.white),
                ),
              ),
              Positioned.fill(
  top: 270, // Adjust the top value as needed
  child: Container(
    width: 335,
    child: Center(
      child: Text(
        '제보자 전화번호',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
      ),
    ),
  ),
),
              Positioned(
                left: 19,
                top: 550,
                child: Container(
                  width: 335,
                  height: 55,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        height: double.infinity,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Color(0xFFC8D1E1)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 24, height: 24),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: phoneNumberController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: '전화번호를 입력하세요(선택)',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Positioned(
                      //   left: 115,
                      //   top: 0,
                      //   child: Text(
                      //     '제보자 전화번호 (선택)',
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 14,
                      //       fontFamily: 'Inter',
                      //       fontWeight: FontWeight.w400,
                      //       height: 0,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
             Positioned(
  left: 20,
  top: 350,
  child: Container(
    width: 335,
    height: 71,
    child: Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            width: 335,
            padding: const EdgeInsets.only(top: 22),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFC8D1E1)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(width: 24, height: 24),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.animalFeatures ?? '', // Display characteristics
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
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
        ),
        Positioned(
          left: 126,
          top: 5,
          child: Text(
            '반려동물 특징',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ],
    ),
  ),
),
              Positioned.fill(
  top: 66, // Adjust the top value as needed
  child: Container(
    width: 335,
    child: Center(
      child: Text(
        '반려동물 발견 위치',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
      ),
    ),
  ),
),
              Positioned(
                left: 20,
                top: 450,
                child: Container(
                  width: 335,
                  height: 55,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        height: double.infinity,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Color(0xFFC8D1E1)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: 24, height: 24),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: discoveryLocationController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: '반려동물 발견 위치를 입력하세요',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Positioned(
                      //   left: 112,
                      //   top: 0,
                      //   child: Text(
                      //     '반려동물 발견 위치',
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 14,
                      //       fontFamily: 'Inter',
                      //       fontWeight: FontWeight.w400,
                      //       height: 0,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
             Positioned(
  left: 19,
  top: 273,
  child: Container(
    width: 336,
    height: 71,
    child: Stack(
      children: [
        Positioned(
          left: 1,
          top: 0,
          child: Container(
            width: 335,
            height: 71,
            padding: const EdgeInsets.only(top: 22),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFC8D1E1)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(width: 24, height: 24),
                        SizedBox(width: 8),  // Add this line to add spacing
                        Expanded(
                          child: Text(
                            widget.animalNickname,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
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
        ),
        Positioned(
          left: 127,
          top: 5,
          child: Text(
            '반려동물 이름',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ],
    ),
  ),
),
              Positioned(
  left: 20,
  top: 620, // Adjust the top value as needed
  child: Row(
    children: [
      ElevatedButton(
        onPressed: () {Navigator.pop(context);
          // Add your logic for canceling the report here
        },
        child: Text('취소'),
      ),
      SizedBox(width: 200), // Add some spacing between buttons
      ElevatedButton(
        onPressed: () {
          String phoneNumber = phoneNumberController.text;
      String discoveryLocation = discoveryLocationController.text;
       print('Phone Number: $phoneNumber');
      print('Discovery Location: $discoveryLocation');
      // phoneNumber = phoneNumber ?? '비공개';
      if (phoneNumber==''){
        phoneNumber='비공개';
      }
    // discoveryLocation = discoveryLocation ?? '';
    print('Phone Number: $phoneNumber');
      print('Discovery Location: $discoveryLocation');
     if (discoveryLocation.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('알림'),
            content: Text('발견 위치를 입력해주세요!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );}
      _jeboPet();
      
          // Add your logic for submitting the report here
        },
        child: Text('제보'),
      ),
    ],
  ),
),
            ],
          ),
        ),
      ],
    ));
  }
}
