import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';
import 'package:flutter_sns_form/src/pages/my_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter_sns_form/src/app.dart';

class RegisterPet extends StatefulWidget {
  final String petName;
  final String petchracteristic;
  final String imageUrl;
  final String animalid;
  
  RegisterPet({
    Key? key,
    required this.petName,
    required this.petchracteristic,
    required this.imageUrl,
    required this.animalid,
  }) : super(key: key);
  
  @override
  _RegisterPetState createState() => _RegisterPetState();
}

class _RegisterPetState extends State<RegisterPet> {
  final TextEditingController location_Controller = TextEditingController();
  final String token=globalToken;
  Future<void> reporting(animalid, location) async {
    Dio dio = Dio();
    dio.options.headers={
      'Authorization': 'Bearer $token'
    };
    dio.options.contentType = 'multipart/form-data';

    var formData = FormData.fromMap({
      'animal_id': animalid,
      'missing_location': location.toString(),
    });

    try {
      Response response = await dio.post(
        'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/animal/alert',
        data: formData,
      );

      print(response);

      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const App(),
          ),
        );
      }
    } catch (error) {
      print("신고실패");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 111, 174, 186),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            RegisteringPet(
              petName: widget.petName,
              petchracteristic: widget.petchracteristic,
              imageUrl: widget.imageUrl,
              locationController: location_Controller,
              animalid: widget.animalid,
              reportingMethod: reporting,
            ),
          ],
        ),
      ),
    );
  }
}

class RegisteringPet extends StatelessWidget {
  final String petName;
  final String petchracteristic;
  final String imageUrl;
  final TextEditingController locationController;
  final Function(String, String) reportingMethod;
  final String ownerPhoneNumber = globalNumber;
  final String animalid;

  RegisteringPet({
    Key? key,
    required this.petName,
    required this.petchracteristic,
    required this.imageUrl,
    required this.locationController,
    required this.reportingMethod,
    required this.animalid,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
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
        image: imageUrl == 'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/media/'
            ? AssetImage('assets/images/unknowndog.png')
            : NetworkImage(imageUrl ?? '') as ImageProvider<Object>,
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
                  height: 425,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30),),
                 
                ),
              ),
              
              Positioned(
  left: 19,
  top: 545,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
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
                        height: null,
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
              top: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center-align vertically
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '주인 전화번호',
                    style: TextStyle(
                      color: Color.fromARGB(138, 15, 179, 133),
            fontSize: 18,
            fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      //fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: 10), // Adjust the spacing between text and box as needed
                  Text(
                    '$ownerPhoneNumber',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
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
              Positioned(
  left: 19,
  top: 451,
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
                    height: null,
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
          top: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '반려동물 특징',
                style: TextStyle(
                  color: Color.fromARGB(138, 15, 179, 133),
            fontSize: 18,
            fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  //fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              SizedBox(height: 10),  // Add some spacing between the label and the actual text
              Text(
                '$petchracteristic',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
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
  top: 362,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          '실종위치',
          style: TextStyle(
            color: Color.fromARGB(138, 15, 179, 133),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            //fontWeight: FontWeight.w400,
            height: 0,
          ),
          textAlign: TextAlign.center, // Center align the text
        ),
        
      ),
      Container(
        width: 335,
        height: 45,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 335,
                padding: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color(0xFFC8D1E1)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextFormField(
                  controller: locationController,
                  onChanged: (value) {
                    // Store the user's input in a variable
                    // You can use this value wherever you need it.
                    // For example, you can declare a variable outside of this build method
                    // and assign the value to it.
                    // String petFeature = value;
                  },
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    hintText: '실종위치를 입력하세요',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
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
  top: 273,
  child: Container(

    width: 336,
    height: 71,
    child: Stack(
      children: [
        //SizedBox(height: 7),
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
                    height: null,
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
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
                    height: null,
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
          top: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '반려동물이름',
                style: TextStyle(
                  color: Color.fromARGB(138, 15, 179, 133),
            fontSize: 18,
            fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  //fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              SizedBox(height: 7),
              Text(
                '$petName',
               
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
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
  left: 160,
  bottom: 140, // Adjust the bottom position as needed
  child: ElevatedButton(
    onPressed: () {
      reportingMethod(animalid,locationController.text);
      print(locationController.text);
      // Handle the "신고" button click event
      // You can add the logic to report here
      // For now, I'm just printing a message
      print('신고 button clicked');
    },
    child: Text('신고', style: TextStyle(fontSize: 16)),
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 111, 174, 186), // Set button background color
      foregroundColor: Colors.white, // Set text color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Set button border radius
      ),
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