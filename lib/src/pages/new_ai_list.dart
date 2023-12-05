import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';



class AIList extends StatelessWidget {
  final Response response;
  final Map<String, dynamic>? mainImage;

  AIList({required this.response, this.mainImage});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> animalData = List<Map<String, dynamic>>.from(response.data['data']);

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
            child: ListTile(
              title: Text(animal['nickname']),
              subtitle: Text('ID: ${animal['id']}'),
              // Customize the ListTile based on your requirements
              leading: mainImage != null
                  ? Image.network(mainImage!['url']) // Adjust based on your response structure
                  : null,
            ),
          );
        },
      ),
    );
  }
}
