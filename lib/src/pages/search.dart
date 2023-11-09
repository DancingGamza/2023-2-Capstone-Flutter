import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:flutter_sns_form/src/pages/catch_pet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_sns_form/src/pages/mypet_list.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  void _navigateToFirstPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CatchPet(),
    ));
  }

  void _navigateToSecondPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MypetList(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('실종',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ),
      backgroundColor: Color.fromARGB(149, 51, 77, 143),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
  onTap: () => _navigateToFirstPage(context),
  child: Container(
    width: 300,
    height: 200,
    decoration: BoxDecoration(
      color: Color.fromARGB(159, 255, 178, 178),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Stack(
      fit: StackFit.expand, // Ensure the child fills the container
      children: [
        Image.network(
          'https://img.freepik.com/free-photo/black-camera-lens-brown-wooden-table_417767-6.jpg?w=1060&t=st=1699551505~exp=1699552105~hmac=523777497ca37b9df3726f206fe3bcf1fa144e7d09a13c51d379a7eb8985ce5b',
          fit: BoxFit.cover, // Image will cover the entire container
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '반려동물 캐치하기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  ),
),

            GestureDetector(
  onTap: (){Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MypetList(),
      ),
    );},
  child: Container(
    width: 300,
    height: 200,
    decoration: BoxDecoration(
      color: Color.fromARGB(159, 255, 178, 178),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Stack(
      fit: StackFit.expand, // Ensure the child fills the container
      children: [
        Image.network(
          'https://plus.unsplash.com/premium_photo-1680303134459-912abf8efe2f?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          fit: BoxFit.cover, // Image will cover the entire container
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '반려동물 신고하기',
              style: TextStyle(
                color:Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}
/*
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Catch Pet!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Text('카메라등장 두둥'),
      ),
    );
  }
}*/
/*
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('두 번째 페이지'),
      ),
      body: Center(
        child: Text('두 번째 페이지입니다.'),
      ),
    );
  }
}*/
