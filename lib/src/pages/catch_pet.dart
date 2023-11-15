import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sns_form/src/pages/check_pic.dart';

class CatchPet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CatchPetPage(),
    );
  }
}

class CatchPetPage extends StatefulWidget {
  @override
  _CatchPetPageState createState() => _CatchPetPageState();
}

class _CatchPetPageState extends State<CatchPetPage> {
  CameraController? _controller;
  late String _imagePath;

  @override
  void initState() {
    super.initState();
    // 카메라 초기화
    WidgetsFlutterBinding.ensureInitialized();
    availableCameras().then((cameras) {
      final backCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back);

      _controller = CameraController(backCamera, ResolutionPreset.medium);
      _controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _capturePhoto() async {
    try {
      final image = await _controller!.takePicture();

      // 앨범에 저장
      final appDir = await getApplicationDocumentsDirectory();
      final savedImage = await File(image.path).copy('${appDir.path}/captured_image.jpg');
      
      // 이미지 경로를 MatchList에 전달
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MatchList(imagePath: savedImage.path),
        ),
      );
    } catch (e) {
      print('사진을 캡쳐하는 중에 오류가 발생했습니다: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Catch Pet!',style: TextStyle(
      fontSize: 30, // 원하는 글씨 크기로 조절
      fontWeight: FontWeight.bold, // 굵기 조절
      color: Color.fromARGB(138, 15, 179, 133),),),
        backgroundColor: Colors.white,
      ),
      //color: Color.fromARGB(255, 44, 60, 143),
      body: Center(
        child: CameraPreview(_controller!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _capturePhoto,
        child: Icon(Icons.camera),
        backgroundColor: Color.fromARGB(255, 111, 174, 186),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
