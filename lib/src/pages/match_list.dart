import 'dart:io';
import 'package:flutter/material.dart';

class MatchList extends StatelessWidget {
  final String imagePath;

  MatchList({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('사진 표시'),
        backgroundColor:Color.fromARGB(255, 44, 60, 143),
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}