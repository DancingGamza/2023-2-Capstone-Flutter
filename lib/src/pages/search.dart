import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  void _navigateToFirstPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FirstPage(),
    ));
  }

  void _navigateToSecondPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SecondPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('실종', style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )),
      ),
      backgroundColor: Color.fromARGB(255, 44, 60, 143),
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
                  borderRadius: BorderRadius.circular(20), // 원하는 라운드 값을 지정합니다.
                ),
                child: ImageData(IconsPath.cameraIcon),
              ),
            ),
            GestureDetector(
              onTap: () => _navigateToSecondPage(context),
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  color: Color.fromARGB(159, 255, 178, 178),
                  borderRadius: BorderRadius.circular(20), // 원하는 라운드 값을 지정합니다.
                ),
                child: ImageData(IconsPath.searchOff),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// FirstPage 및 SecondPage 위젯은 이전 코드와 동일합니다.


// FirstPage 및 SecondPage 위젯은 이전 코드와 동일합니다.
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catch Pet!',style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color:Colors.white,),),
      ),
      body: Center(
        child: Text('카메라등장 두둥'),
      ),
    );
  }
}

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
}