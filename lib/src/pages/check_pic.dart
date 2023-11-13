import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';
import 'package:flutter_sns_form/src/pages/my_page.dart';
import 'package:flutter_sns_form/src/app.dart';
class MatchList extends StatelessWidget {
  final String imagePath;
  final String token = globalToken;
  MatchList({required this.imagePath});

  String myMessage = '';

  Future<void> goai(BuildContext context, File imageFile) async {
    Dio dio = Dio();

    
    dio.options.headers = {
      'Authorization': 'Bearer $token'
    };
    dio.options.contentType = 'multipart/form-data';


  
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imageFile.path),
    });

    try {
      Response response = await dio.post(
        'http://ec2-13-209-75-120.ap-northeast-2.compute.amazonaws.com/post/missing/create/',
        data: formData,
      );
      print("lllll");
      print(response);

      if (response.statusCode == 201) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const App(),
          ),
        );
      } else {
        //final Map<String, dynamic> error = json.decode(response.body);
        //print('Error Message: ${error['message']}');
        myMessage = "로그인 실패";
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('사진 표시'),
        backgroundColor: Color.fromARGB(149, 51, 77, 143),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.file(File(imagePath)),
          ),
          SizedBox(height: 20), // Adjust the spacing between the image and the button
          ElevatedButton(
            onPressed: () {
              // Add your confirmation logic here
              // For example, you can navigate to a new screen or perform some action
              print('확인 button pressed!');
              goai(context, File(imagePath));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(149, 51, 77, 143), // Set the button color here
            ),
            child: Text('확인'),
          ),
        ],
      ),
    );
  }
}
