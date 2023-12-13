import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/jebo.dart';

class AIList extends StatelessWidget {
  final Response response;
  final Map<String, dynamic>? mainImage;

  AIList({required this.response, this.mainImage});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> animalData =
        List<Map<String, dynamic>>.from(response.data['data']);
    int animalPicId = response.data['message'];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          '매칭리스트',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'DungGeunMo',
            color: Color.fromARGB(138, 15, 179, 133),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: animalData.length,
        itemBuilder: (context, index) {
          final animal = animalData[index];
          return GestureDetector(
            onTap: () {
              print("9999999");
              print(animal['id']);
              print(animal['nickname']);
              print(animal['characteristic']);
              print(animal['main_img']);
              print("9999999");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Jebo(
                    animalId: animal['id'].toString(),
                    animalNickname: animal['nickname'].toString(),
                    animalFeatures: animal['characteristic'].toString(),
                    animalImageUrl: animal['main_img'].toString(),
                    animalPicId: animalPicId.toString(),
                  ),
                ),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage('http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/media/'+animal['main_img']),
                    ),
                    SizedBox(width: 16),
                    Text(
                      animal['nickname'],
                      style: TextStyle(fontFamily: 'DungGeunMo'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
