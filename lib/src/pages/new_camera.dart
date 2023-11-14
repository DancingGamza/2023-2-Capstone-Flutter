import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';
String galleryPath='';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late File _imageFile;

  @override
  void initState() {
    super.initState();
    // 빈 파일로 초기화
    _imageFile = File('');
    _captureAndSave(); // initState에서 바로 카메라 호출
  }

  Future<void> _captureAndSave() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return; // 사용자가 취소한 경우
    setState(() {
      _imageFile = File(image.path);
    });

    // 이미지 파일이 실제로 존재하는지 확인
    if (await _imageFile.exists()) {
      // 이미지 파일을 Uint8List로 읽어오기
      final Uint8List uint8List = await _imageFile.readAsBytes();

      // 갤러리에 저장
      final result = await ImageGallerySaver.saveImage(uint8List);
      var mypath=result['filePath'];
      galleryPath=mypath;
      if (result['isSuccess']) {
        print('사진이 갤러리에 저장되었습니다.');
        print('갤러리 경로: ${result['filePath']}');
        galleryPath = result['filePath'];
      } else {
        print('사진 저장에 실패했습니다.');
      }
    } else {
      print('이미지 파일이 존재하지 않습니다.');
    }
  }



Future<void> uploadImage(String filepath,BuildContext context) async {
    Dio dio = Dio();
    //String fileName = file.path.split('/').last;
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    dio.options.contentType = 'multipart/form-data';
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(filepath),
    });
    print("ㅇㅇㅇ");
    print(galleryPath);
    try {
      Response response = await dio.post(
        'http://ec2-13-209-75-120.ap-northeast-2.compute.amazonaws.com/posts/missing/create/',
        data: formData,
      );

      print(response);

      if (response.statusCode == 201) {
        print("201입니다윤");
        // Uncomment the next lines if you want to navigate after a successful upload
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => const App(),
        //   ),
        // );
      } else {
        print("400이에요");
      }
    } catch (e) {
      print("응 아예 서버로부터 값도 못받아옴 ㅅㄱ");
      print('Error: $e');
      //print(imagePath);
    }
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Example'),
        actions: [
          IconButton(
            onPressed: () {
              uploadImage(galleryPath, context); // 확인 버튼 누를 때 이미지 업로드
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Center(
        child: _imageFile == null || _imageFile.path.isEmpty
            ? Text('유기견을 빨리 찍어주세요..!')
            : Image.file(_imageFile),
      ),
    );
  }
}