import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';
import 'package:flutter_sns_form/src/pages/abc.dart';


class AIList extends StatelessWidget {
  final Response response;
  final Map<String, dynamic>? mainImage;

  AIList({required this.response, this.mainImage});
  
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> animalData = List<Map<String, dynamic>>.from(response.data['data']);
     int animalPicId = response.data['message'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal List'),
        backgroundColor: Color.fromARGB(255, 111, 174, 186),
      ),
      body: ListView.builder(
        itemCount: animalData.length,
        itemBuilder: (context, index) {
          final animal = animalData[index];
          return Card(
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
    child: ListTile(
      title: Text(animal['nickname']),
      //subtitle: Text('ID: ${animal['id']}'),
      leading: mainImage != null
          ? Image.network(mainImage!['url'])
          : null,
    ),
  ),
);
        },
      ),
    );
  }
}