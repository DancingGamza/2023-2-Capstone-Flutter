import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/new_modify_pet_info.dart';
import 'package:flutter_sns_form/src/pages/login.dart';
import 'package:flutter_sns_form/src/pages/fix_pet_list.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:flutter_sns_form/src/app.dart';
class FixMypetList extends StatefulWidget {
  @override
  _FixMypetListState createState() => _FixMypetListState();
}

class _FixMypetListState extends State<FixMypetList> {
  final Dio dio = Dio();
  final String token = globalToken;
  List<String> nicknamePets = [];
  List<String> petchracteristics = [];
  List<String> mainimageUrls = [];
  List<String> animalids = [];

  @override
  void initState() {
    super.initState();
    requestAnimalInfo(token);
  }

  Future<void> requestAnimalInfo(String token) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    try {
      Response response = await dio.get(
          'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/animal/list');
      if (response.statusCode == 200) {
        print("Success: ${response.data}");
        var animalInfo = response.data;
        setState(() {
          var data = animalInfo['data'];
          nicknamePets = List<String>.from(
              data.map((animal) => animal['nickname'].toString()));
          petchracteristics = List<String>.from(
              data.map((animal) => animal['characteristic'].toString()));
          mainimageUrls = List<String>.from(
              data.map((animal) => animal['main_img'].toString()));
          animalids =
              List<String>.from(data.map((animal) => animal['id'].toString()));
        });
      } else if (response.statusCode == 401) {
        print("Authentication Error: ${response.data}");
        // Handle authentication errors or token issues here.
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: ImageData(IconsPath.mylist, width: 270),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView.builder(
          itemCount: nicknamePets.length + 1, // Add 1 for the new card
          itemBuilder: (context, index) {
            if (index == nicknamePets.length) {
              // This is the new card
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 2.0, // Add elevation for a shadow
                  color: Colors.grey, // Set the card color to gray
                  child: InkWell(
                    onTap: () {
                      _showNewPetDialog(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12.0), // Add padding for separation
                      child: Center(
                        child: Text(
                          '신규 등록하기',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Set text color to white
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              // This is the regular card
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 2.0, // Add elevation for a shadow
                  child: InkWell(
                    onTap: () => navigateToNextPage(
                      nicknamePets[index],
                      petchracteristics[index],
                      mainimageUrls[index],
                      animalids[index],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/mybar4.jpg",
                            width: double.infinity,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: ListTile(
                              title: Text(
                                '동물 닉네임: ${nicknamePets[index]}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
  void _showNewPetDialog(BuildContext context) {




    String newPetName = "";
    String newPetCharacteristics = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('신규 등록'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  newPetName = value;
                },
                decoration: InputDecoration(labelText: '동물 이름'),
              ),
              TextField(
                onChanged: (value) {
                  newPetCharacteristics = value;
                },
                decoration: InputDecoration(labelText: '동물 특징'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle confirmation logic here
                // You can use newPetName and newPetCharacteristics
                // for further processing.
                print("44444");
                print(newPetName);
                print(newPetCharacteristics);
                print("44444");
                _sendNewPetInfoToServer(newPetName, newPetCharacteristics);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
  void _sendNewPetInfoToServer(String petName, String characteristics) async {
  try {
    Dio dio4 = Dio();
    dio4.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
      // Add other headers as needed
    };

    FormData formData = FormData.fromMap({
      'nickname': petName,
      'characteristic': characteristics,
      // Add other form fields as needed
    });

    Response response = await dio4.post(
        'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/animal/create',
        data: formData,
      );

    if (response.statusCode == 201) {
       // Handle successful response
      print('New pet information sent successfully');

      // Show completion message
      _showCompletionDialog();

      // Navigate to another page (replace with your page navigation logic)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => App(),
        ),
      );
    } else {
      // Handle error response
      print('Error sending new pet information: ${response.data}');
    }
  } catch (e) {
    // Handle Dio4 errors
    print('Dio error: $e');
  }
}
void _showCompletionDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('등록 완료'),
        content: Text('새로운 펫이 등록되었습니다.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('확인'),
          ),
        ],
      );
    },
  );
}



  void navigateToNextPage(
      String nicknamePet, String petchracteristic, String imageUrl, String animalid) {
    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => FixingMyPet(
      petName: nicknamePet,
      petCharacteristic: petchracteristic,
      imageUrl: "http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/media/" + imageUrl,
      animalId: animalid,
    ),
  ),
);
  }
}


