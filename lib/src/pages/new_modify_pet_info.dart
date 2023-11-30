import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter_sns_form/src/pages/login.dart';


class FixingMyPet extends StatelessWidget {
  final String petName;
  final String petCharacteristic;
  final String imageUrl;
  final String animalId;

  const FixingMyPet({
    required this.petName,
    required this.petCharacteristic,
    required this.imageUrl,
    required this.animalId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 111, 174, 186),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            PetDetails(
              imageUrl: imageUrl,
              petName: petName,
              petFeatures: petCharacteristic,
              animalId: animalId,
              // imageUrl: "https://via.placeholder.com/189x184",
              // petName: "Max",
              // petFeatures: "Friendly, Playful",
            ),
          ],
        ),
      ),
    );
  }
}

class PetDetails extends StatefulWidget {
  final String imageUrl;
  final String petName;
  final String petFeatures;
  final String animalId;
  const PetDetails({
    required this.imageUrl,
    required this.petName,
    required this.petFeatures,
    required this.animalId,
    Key? key,
  }) : super(key: key);

  @override
  _PetDetailsState createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _featuresController = TextEditingController();
  late String _name;
  late String _features;

//이미지 등록하기 함수짜는곳


Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      // Call the function to upload the image
      await _uploadImage(imageFile);
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        'animal_id': widget.animalId,
        'image': await MultipartFile.fromFile(imageFile.path),
      });

      Response response = await dio.post(
        'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/animal/image/create',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Image uploaded successfully
        print('Image uploaded successfully');
        // Handle any additional logic if needed
      } else {
        // Handle the error
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle the exception
      print('Error uploading image: $error');
    }
  }





//이미지등록하기 함수끝
  @override
  void initState() {
    super.initState();
    _name = widget.petName;
    _features = widget.petFeatures;

    _nameController.text = _name;
    _featuresController.text = _features;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 375,
          height: 702,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color.fromARGB(255, 111, 174, 186)),
          child: Stack(children: [
            Positioned(
  left: 93,
  top: 50,
  child: Container(
    width: 189,
    height: 184,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: widget.imageUrl == 'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/media/'
            ? AssetImage('assets/images/unknowndog.png')
            : NetworkImage(widget.imageUrl ?? '') as ImageProvider<Object>,
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
            Positioned(
              left: 19,
              top: 273,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '반려동물 이름',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 336,
                    height: 71,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 1,
                          top: 0,
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: Container(
                              width: 335,
                              height: 71,
                              padding: const EdgeInsets.only(top: 22),
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: _nameController,
                                onChanged: (value) {
                                  _name = value;
                                },
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFC8D1E1),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFC8D1E1),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 19,
              top: 391,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '반려동물 특징',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 336,
                    height: 71,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 1,
                          top: 0,
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: Container(
                              width: 335,
                              height: 71,
                              padding: const EdgeInsets.only(top: 22),
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: _featuresController,
                                onChanged: (value) {
                                  _features = value;
                                },
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFC8D1E1),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFC8D1E1),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),


//버튼을 수정하는곳..............

            Positioned(
          left: 19,
          top: 510,
          child: ElevatedButton(
            onPressed: _pickImage,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), // Change color here
            ),
            child: Text('이미지 등록하기'),
          ),
        ),

Positioned(
  left: 150,
  top: 510,
  child: ElevatedButton(
    onPressed: () {
      // Handle setting the image as the representative image logic
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Change color here
    ),
    child: Text('대표이미지 설정'),
  ),
),

Positioned(
  left: 280,
  top: 510,
  child: ElevatedButton(
    onPressed: () {
      // Handle update logic
      String updatedName = _nameController.text;
      String updatedFeatures = _featuresController.text;
      // Update the pet details as needed
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Change color here
    ),
    child: Text('수정'),
  ),
),

          ]),
        )
      ],
    );
  }
}
