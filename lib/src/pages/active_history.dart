import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/avatar_widget.dart';
class ActiveHistory extends StatelessWidget{
  const ActiveHistory({Key?key}):super(key:key);

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
          _activeitemOne(),
          _activeitemOne(),
          _activeitemOne(),
          _activeitemOne(),
          _activeitemOne(),
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
          _activeitemOne(),
          _activeitemOne(),
          _activeitemOne(),
          _activeitemOne(),
          _activeitemOne(),
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
          _activeitemOne(),
          _activeitemOne(),
          _activeitemOne(),
          _activeitemOne(),
          _activeitemOne(),
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
        title: const Text(
          '활동',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color:Colors.white,
            ),
            ),
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