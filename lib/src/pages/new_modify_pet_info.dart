import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter_sns_form/src/pages/login.dart';
import 'package:flutter_sns_form/src/pages/pick_main_image.dart';
import 'package:flutter_sns_form/src/app.dart';
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
    return 
//여기가 문제


      // theme: ThemeData.light().copyWith(
        // scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255)   ,
        // ),
      Scaffold(
        
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: ListView(
          children: [
            PetDetails(
              imageUrl: imageUrl,
              petName: petName,
              petFeatures: petCharacteristic,
              animalId: animalId,
              
            ),
          ],
        ));
      
    
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

  late String representImageUrl;
late String representImageId;




//동물정보 삭제하기 함수짜는곳
 Future<void> _deletePet() async {
    try {
      Dio dio = Dio();
      Response response = await dio.delete(
        'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/animal/${widget.animalId}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
             'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('삭제 완료'),
            content: Text('삭제가 완료되었습니다.'),
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
        // // Display a success message
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text('Pet deleted successfully!'),
        // ));

        // // Navigate to the App() page
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => const App(),
        //   ),
        // );
      } else {
        // Handle the error
        print('Failed to delete pet. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle the exception
      print('Error deleting pet: $error');
    }
  }
















//동물정보 수정하기 함수 짜는곳
Future<void> _updatePetDetails() async {

    



        Dio dio = Dio();
    dio.options.headers = {'Authorization': 'Bearer $token'};
    dio.options.contentType = 'multipart/form-data';

    var formData = FormData.fromMap({
      
      'nickname':_nameController.text,
      'characteristic': _featuresController.text,
    });

    try {
      Response response = await dio.put(
        'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/animal/${widget.animalId}',
        data: formData,
      );




      if (response.statusCode == 200) {
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('수정 완료'),
            content: Text('수정이 완료되었습니다.'),
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
        print('Failed to update pet details. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle the exception
      print('Error updating pet details: $error');
    }
  }


// //실종신고 해제하는 함수 짜는곳
// Future<void> _unregister() async{
//   try {
//     Dio dio =Dio();
//     Response response = await dio.put('http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/',options:Options(headers:{
//       'Authorization':'Bearer $token',
//       'Content-Type': 'multipart/form-data',
//     },),);
//     if (response.statusCode == 200) {
//         // Extract and return the list of images from the response data
//         print('신고해지완료');
//       } else {
//         // Handle the error
//         print('failing unregister');
//       }
//     } catch (error) {
//       // Handle the exception
//       print('Error unregister: $error');
     
//     }
//   }
// }


//대표이미지 등록하기 함수 짜는곳
  Future<List<Map<String, dynamic>>> _fetchImages() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/animal/image/list/${widget.animalId}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Extract and return the list of images from the response data
        List<Map<String, dynamic>> images = List<Map<String, dynamic>>.from(response.data['data']);
        return images;
      } else {
        // Handle the error
        print('Failed to fetch images. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      // Handle the exception
      print('Error fetching images: $error');
      return [];
    }
  }
Future<void> _navigateToImageAlbum() async {
  try {
    // Fetch the list of images from the API
    List<Map<String, dynamic>> images = await _fetchImages();

    // Check if there are images before navigating
    if (images.isNotEmpty) {
      // Navigate to the image album page with the images from the API response
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageAlbumPage(images: images),
        ),
      );
    } else {
      // Handle the case where no images were fetched
      print('No images available.');
    }
  } catch (error) {
    // Handle the exception
    print('Error navigating to image album: $error');
  }
}

//이미지 등록하기 함수짜는곳

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

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
        'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/animal/image/create',
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
                    image: widget.imageUrl ==
                            'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/media/'
                        ? AssetImage('assets/images/unknowndog.png')
                        : NetworkImage(widget.imageUrl ?? '')
                            as ImageProvider<Object>,
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
                      fontFamily: 'DungGeunMo',
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  //SizedBox(height: 8),
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
                      fontFamily: 'DungGeunMo',
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  //SizedBox(height: 8),
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
              left: 120,
              top: 510,
              child: ElevatedButton(
                onPressed: _pickImage,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(138, 15, 179, 133)), // Change color here
                ),
                child: Text('새 이미지 등록하기',style:TextStyle(fontFamily: 'DungGeunMo')),
              ),
            ),





















            Positioned(
  left: 130,
  top: 560,
  child: ElevatedButton(
    onPressed: _navigateToImageAlbum,
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(138, 15, 179, 133)),
    ),
    child: Text('대표이미지 등록',style:TextStyle(fontFamily: 'DungGeunMo')),
  ),
),



            Positioned(
          left: 293,
          top: 640,
          child: ElevatedButton(
            onPressed: _updatePetDetails,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 111, 174, 186)), // Change color here
            ),
            child: Text('수정',style:TextStyle(fontFamily: 'DungGeunMo')),
          ),
        ),

        //     Positioned(
        //   left: 155,
        //   top: 640,
        //   child: ElevatedButton(
        //     onPressed:
        //     style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.all<Color>(
        //           Color.fromARGB(255, 174, 91, 161)), // Change color here
        //     ),
        //     child: Text('실종해제'),
        //   ),
        // ),

//             Positioned(
//           left: 20,
//           top: 640,
//           child: ElevatedButton(
//             onPressed: _deletePet,
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all<Color>(
//                   const Color.fromARGB(255, 153, 153, 153)), // Change color here
//             ),
//             child: Text('삭제'),
//           ),
//         ),
           ]),
        )
       ],
    );
 }
}