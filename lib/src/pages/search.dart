import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/pages/catch_pet.dart';
import 'package:flutter_sns_form/src/pages/mypet_list.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:flutter_sns_form/src/pages/new_catch_pet.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  void _navigateToFirstPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      //builder: (context) => CatchPet(),
      //builder: (context) => HardPet(),
      builder: (context) => HardPet(),
    ));
  }

  void _navigateToSecondPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MypetList(),
    ));
  }

Widget _buildCard(String imagePath, String title, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Material(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          
        ),
        elevation: 0.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: 300,
                height: 150,
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: Color.fromARGB(138, 15, 179, 133), // Change the color here
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle:true,
        title:ImageData(IconsPath.upsearch,width:270),
        /*
        elevation: 0,
        centerTitle: true,
        title: Text(
          '실종',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(138, 15, 179, 133),
          ),
        ),*/
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCard(
              'assets/images/toycam.jpg',
              '반려동물 캐치하기',
              () => _navigateToFirstPage(context),
            ),
            _buildCard(
              'assets/images/toyspeaker.jpg',
              '내 반려동물 실종신고',
              () => _navigateToSecondPage(context),
            ),
          ],
        ),
      ),
    );
  }
}
