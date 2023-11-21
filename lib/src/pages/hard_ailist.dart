import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/pages/bbobbi_profile.dart';
import 'package:flutter_sns_form/src/pages/fox_profile.dart';
import 'package:flutter_sns_form/src/pages/haneul_profile.dart';
import 'package:flutter_sns_form/src/pages/peet_profile.dart';
import 'package:flutter_sns_form/src/pages/sherry_profile.dart';
void main() {
  runApp(HardAIList());
}

class HardAIList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('AI 판독 결과',style: TextStyle(color:Color.fromARGB(138, 15, 179, 133),fontFamily: 'DungGeunMo',fontSize: 24,fontWeight: FontWeight.bold ),),
        ),
        body: ListView(
          children: [
            PetCard(
              petName: '1. 뽀삐',
              imagePath: 'assets/images/mybar4.jpg',
              onTap: () {
                navigateToDetailPage(context, '뽀삐');
              },
            ),
            SizedBox(height: 16),
            PetCard(
              petName: '2. 하늘',
              imagePath: 'assets/images/mybar4.jpg',
              onTap: () {
                navigateToDifferentPage(context, '하늘');
              },
            ),
            SizedBox(height: 16),
            PetCard(
              petName: '3. 셰리',
              imagePath: 'assets/images/mybar4.jpg',
              onTap: () {
                navigateToAnotherPage(context, '셰리');
              },
            ),
            SizedBox(height: 16),
            PetCard(
              petName: '4. 여우',
              imagePath: 'assets/images/mybar4.jpg',
              onTap: () {
                navigateToSpecificPage(context, '여우');
              },
            ),
            SizedBox(height: 16),
            PetCard(
              petName: '5. 피트',
              imagePath: 'assets/images/mybar4.jpg',
              onTap: () {
                navigateToCustomPage(context, '피트');
              },
            ),
          ],
        ),
      ),
    );
  }

  void navigateToDetailPage(BuildContext context, String petName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => bbobbiProfile()),
    );
  }

  void navigateToDifferentPage(BuildContext context, String petName) {
    // Add navigation logic for '하늘'
    Navigator.push(context, MaterialPageRoute(builder: (context) => haneulProfile()));
  }

  void navigateToAnotherPage(BuildContext context, String petName) {
    // Add navigation logic for '셰리'
    Navigator.push(context, MaterialPageRoute(builder: (context) => sherryProfile()));
  }

  void navigateToSpecificPage(BuildContext context, String petName) {
    // Add navigation logic for '여우'
    Navigator.push(context, MaterialPageRoute(builder: (context) => foxProfile()));
  }

  void navigateToCustomPage(BuildContext context, String petName) {
    // Add navigation logic for '피트'
    Navigator.push(context, MaterialPageRoute(builder: (context) => peetProfile()));
  }
}

class PetCard extends StatelessWidget {
  final String petName;
  final String imagePath;
  final VoidCallback? onTap;

  PetCard({required this.petName, required this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              width: double.infinity,
              height: 50,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 16,
              left: 16,
              child: Text(
                petName,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String petName;

  DetailPage({required this.petName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        title: Text(petName),
      ),
      body: Center(
        child: Text('AI 판독 결과'),
      ),
    );
  }
}
