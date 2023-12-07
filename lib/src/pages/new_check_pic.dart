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

  Future<void> uploadImage(File file, BuildContext context) async {
  Dio dio = Dio();
  String fileName = file.path.split('/').last;
  dio.options.headers = {
    'Authorization': 'Bearer $token',
  };
  dio.options.contentType = 'multipart/form-data';
  FormData formData = FormData.fromMap({
    "image": await MultipartFile.fromFile(file.path, filename: fileName),
  });

  // Capture the BuildContext before entering the asynchronous block
  BuildContext currentContext = context;

  print("ㅇㅇㅇ");
  print(file.path);
  try {
    Response response = await dio.post(
      'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/post/missing/create',
      data: formData,
    );
    print("나나나나나");
    print(response);
    print("리리리리리");

    if (response.statusCode == 201) {
      Map<String, dynamic>? mainImage = response.data['main_img'];
      print("201입니다윤");
      // Use the captured BuildContext
      Navigator.of(currentContext).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AIList(response: response, mainImage: mainImage),
        ),
      );
    } else {
      print("400이에요");
    }
  } catch (e) {
    print("응 아예 서버로부터 값도 못받아옴 ㅅㄱ");
    print('Error: $e');
    print(imagePath);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('사진 표시'),
        backgroundColor: Color.fromARGB(255, 111, 174, 186),
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
              await uploadImage(File(newImagePath), context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 111, 174, 186),
            ),
            child: Text('확인'),
          ),
        ],
      ),
    );
  }
}