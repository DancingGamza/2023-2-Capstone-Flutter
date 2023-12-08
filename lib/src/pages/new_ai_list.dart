import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';
import 'package:flutter_sns_form/src/pages/jebo.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
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
      title: Text('매칭리스트',style: TextStyle(
      fontSize: 30, // 원하는 글씨 크기로 조절
      fontWeight: FontWeight.bold, // 굵기 조절
      fontFamily: 'DungGeunMo',
      color: Color.fromARGB(138, 15, 179, 133),),),

    ),
    backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: animalData.length,
        itemBuilder: (context, index) {
          final animal = animalData[index];
          return Card(
            elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
            child: GestureDetector(
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
                    builder: (context) => Material(
                      child: Jebo(
                        animalId: animal['id'].toString(),
                        animalNickname: animal['nickname'].toString(),
                        animalFeatures: animal['characteristic'].toString(),
                        animalImageUrl: animal['main_img'].toString(),
                        animalPicId: animalPicId.toString(),
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/robotbar4.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListTile(
                  title: Text(animal['nickname'],style:TextStyle(fontFamily: 'DungGeunMo')),
                  //subtitle: Text('ID: ${animal['id']}'),
                  leading: mainImage != null
                      ? Image.network(mainImage!['url'])
                      : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}