import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:flutter_sns_form/src/pages/new_ai_list.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_sns_form/src/pages/login.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:flutter_sns_form/src/pages/new_ai_list.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_sns_form/src/pages/login.dart';

class HardList extends StatelessWidget {
  final String imagePath;
  final String token = globalToken;

  HardList({required this.imagePath});

  Future<String> _moveImageToExternalStorage() async {
    final appDir = await getDownloadsDirectory();
    final newImagePath =
        '${appDir!.path}/${DateTime.now().millisecondsSinceEpoch}.png';

    await File(imagePath).copy(newImagePath);

    return newImagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('사진확인',style: TextStyle(fontFamily: 'DungGeunMo',color:Color.fromARGB(138, 15, 179, 133) ),),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.file(File(imagePath)),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              String newImagePath = await _moveImageToExternalStorage();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SplashScreen(
                    imagePath: newImagePath,
                    onSuccess: (response, mainImage) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AIList(
                            response: response,
                            mainImage: mainImage,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 111, 174, 186),
            ),
            child: Text('전송',style:TextStyle(fontFamily:'DungGeunMo',)),
          ),
        ],
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final String imagePath;
  final Function(Response, Map<String, dynamic>?) onSuccess;

  SplashScreen({required this.imagePath, required this.onSuccess});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _processImageAndUpload();
  }

  _processImageAndUpload() async {
    Dio dio = Dio();
    String fileName = widget.imagePath.split('/').last;
    dio.options.headers = {
      'Authorization': 'Bearer ${globalToken}',
      'Content-Type': 'multipart/form-data',
    };

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(widget.imagePath, filename: fileName),
    });

    try {
      Response response = await dio.post(
        'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/post/missing/create',
        data: formData,
      );

      if (response.statusCode == 201) {
        Map<String, dynamic>? mainImage = response.data['main_img'];
        widget.onSuccess(response, mainImage);
      } else {
        print("400이에요");
      }
    } catch (e) {
      print("응 아예 서버로부터 값도 못받아옴");
      print('Error: $e');
      print(widget.imagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ailoading.png'),
          ],
        ),
      ),
    );
  }
}