import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';
import 'package:flutter_sns_form/src/pages/register_lost_pet.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
class MypetList extends StatefulWidget {
  @override
  _MypetListState createState() => _MypetListState();
}

class _MypetListState extends State<MypetList> {
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
          'http://ec2-13-209-75-120.ap-northeast-2.compute.amazonaws.com/animals/mylist/');
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
      title: ImageData(IconsPath.mylist,width:270),
      /* Text(
        '내 펫 리스트',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(138, 15, 179, 133),
        ),
      ),*/

    ),
    backgroundColor: Colors.white,
    body: Center(
      child: ListView.builder(
        itemCount: nicknamePets.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              child: InkWell(
                onTap: () => navigateToNextPage(
                  nicknamePets[index],
                  petchracteristics[index],
                  mainimageUrls[index],
                  animalids[index],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0), // 원하는 둥근 정도 설정
                  child: Stack(
                    children: [
                      // 이미지 추가
                      Image.asset(
                        "assets/images/mybar4.jpg",
                        width: double.infinity,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      // 텍스트 추가
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
        },
      ),
    ),
  );
}


  void navigateToNextPage(
      String nicknamePet, String petchracteristic, String imageUrl, String animalid) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterPet(
          key: null,
          petName: nicknamePet,
          petchracteristic: petchracteristic,
          imageUrl:
              "http://ec2-13-209-75-120.ap-northeast-2.compute.amazonaws.com/media/" +
                  imageUrl,
          animalid: animalid,
        ),
      ),
    );
  }
}


/*
class PetDetailsPage extends StatelessWidget {
  final String nicknamePet;
  final String imageUrl;
  final String petFeature;
  PetDetailsPage({required this.nicknamePet,required this.petFeature, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('동물 상세 정보'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('선택한 동물 닉네임: ${nicknamePet??"아직 등록된 동물이 없습니다"}'),
            // Display the image URL here if needed.
          ],
        ),
      ),
    );
  }
}
*/
