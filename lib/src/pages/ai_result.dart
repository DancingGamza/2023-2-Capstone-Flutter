import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';
import 'package:flutter_sns_form/src/pages/register_lost_pet.dart';

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
          'http://ec2-13-209-75-120.ap-northeast-2.compute.amazonaws.com/animal/mylist/');
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
        title: Text('내 펫 리스트',style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        
      ),
      backgroundColor: Color.fromARGB(149, 51, 77, 143),
      body: Center(
        child: ListView.builder(
          itemCount: nicknamePets.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () => navigateToNextPage(
                    nicknamePets[index],
                    petchracteristics[index],
                    mainimageUrls[index],
                    animalids[index]),
                title: Text('동물 닉네임: ${nicknamePets[index]}'),
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
