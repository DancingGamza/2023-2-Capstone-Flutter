import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/avatar_widget.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';


class ActiveHistory1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ActiveHistory(context:context),
    );
  }
}



class ActiveHistory extends StatelessWidget{
  final BuildContext context;

  const ActiveHistory({Key? key, required this.context}) : super(key: key);
  //const ActiveHistory({Key?key}):super(key:key);
/*
  Widget _activeitemOne(){
    return Padding(padding:const EdgeInsets.symmetric(vertical:10),
    child: Row(children: [
      AvatarWidget(
        type: AvatarType.TYPE2,
        size:40,
        thumbPath:'https://img.freepik.com/premium-photo/adorable-samoyed-puppy-running-on-the-lawn_231786-4512.jpg'
      ),
      const SizedBox(width:10),
      Expanded(
        child: Text.rich(
          TextSpan(
            text:'유나님',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              ),
              children:[
                TextSpan(text:'님이 회원님의 게시물을 좋아합니다.  ',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                ),
                TextSpan(text:'5일전',
                style: TextStyle(
                  fontSize:13,
                  fontWeight: FontWeight.normal,
                  color: Colors.black45,
                ),
                ),
              ]
            ),
            ),
            ),
    ],
    ),);
  }
*/





Widget _activeitemOne(BuildContext context) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: InkWell(
      onTap: () {
        _showMessageBox(
          context,
          '시험용',
          '이것은 추가적인 내용입니다.\n더 많은 내용을 여기에 추가할 수 있습니다.',
          'assets/images/dog1.jpg',
        );
      },
      child: Container(
   
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage('assets/images/mybar4.jpg'), // Replace with your background image asset path
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/footprint.jpg'), // Replace with your image asset path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Doglover',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '당신의 게시글에 발자국을 남겼습니다!',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '1일전',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ));
}
Widget _activeitemTwo() {
  return Card(
    elevation: 2, // Adjust the elevation as needed
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage('assets/images/mybar4.jpg'), // Replace with your background image asset path
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/footprint.jpg'), // Replace with your image asset path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '시츄는역시시츄',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '당신의 게시글에 발자국을 남겼습니다!',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '2일전',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _activeitemThree() {
  return Card(
    elevation: 2, // Adjust the elevation as needed
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage('assets/images/mybar4.jpg'), // Replace with your background image asset path
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/footprint.jpg'), // Replace with your image asset path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '유나',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '당신의 게시글에 발자국을 남겼습니다!',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '3일전',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _activeitemfour() {
  return Card(
    elevation: 2, // Adjust the elevation as needed
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage('assets/images/mybar4.jpg'), // Replace with your background image asset path
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/footprint.jpg'), // Replace with your image asset path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '소희',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '당신의 게시글에 발자국을 남겼습니다!',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '5일전',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _activeitemFive() {
  return Card(
    elevation: 2, // Adjust the elevation as needed
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage('assets/images/mybar4.jpg'), // Replace with your background image asset path
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/footprint.jpg'), // Replace with your image asset path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '지수',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '당신의 게시글에 발자국을 남겼습니다!',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '5일전',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _activeitemSix() {
  return Card(
    elevation: 2, // Adjust the elevation as needed
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage('assets/images/mybar4.jpg'), // Replace with your background image asset path
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/footprint.jpg'), // Replace with your image asset path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '재민',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '당신의 게시글에 발자국을 남겼습니다!',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '8일전',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    
  );
  
}

void _showMessageBox(BuildContext context, String title, String contentText, String imagePath) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        contentPadding: EdgeInsets.all(20.0), // 여기서 여백을 조절
        content: Column(
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(contentText),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('확인'),
          ),
        ],
      );
    },
  );
}
  Widget _newRecentlyActiveView(){
    return Padding( 
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      const Text(
        '오늘',
        style: TextStyle(
          //fontWeight: FontWeight.bold,
          fontSize: 16,
          ),
          ),
          const SizedBox(height:15),
          _activeitemOne(context),
          _activeitemTwo(),
          _activeitemThree(),
          //_activeitemOne(),
          //_activeitemOne(),
    ],
    ),
    );
  }

  Widget _newRecentlyThisMonthView(){
    return Padding( 
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      Text(
        '이번달',
        style: TextStyle(
          //fontWeight: FontWeight.bold,
          fontSize: 16,
          ),
          ),
          const SizedBox(height:15),
          _activeitemSix(),
          _activeitemOne(context),
          //_activeitemOne(),
          //_activeitemOne(),
          //_activeitemOne(),
    ],
    ),
    );
  }

  Widget _newRecentlyThisWeekView(){
   return Padding( 
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      Text(
        '이번주',
        style: TextStyle(
          //fontWeight: FontWeight.bold,
          fontSize: 16,
          ),
          ),
          const SizedBox(height:15),
          _activeitemfour(),
          _activeitemFive(),
          //_activeitemOne(),
          //_activeitemOne(),
          //_activeitemOne(),
    ],
    ),
    );
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation:0,
        centerTitle:true,
        title:ImageData(IconsPath.upfootprint,width:200),
        /*
        title: const Text(
          '활동',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color:Colors.white,
            ),
            ),*/
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _newRecentlyActiveView(),
                  _newRecentlyThisWeekView(),
                  _newRecentlyThisMonthView(),
                ],
                ),
                ),
    );
  }
}