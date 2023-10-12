import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/avatar_widget.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
class PostWidget extends StatelessWidget{
  const PostWidget({Key?key}):super(key:key);
//34:59
/*아바타 타입2는 닉네임이랑 같이 보여짐*/ 
Widget _header() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal:15.0) ,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      
       AvatarWidget(
          type: AvatarType.TYPE2,
          nickname: 'YunaPark',
          size :40,
          thumbPath: 'https://www.cdc.gov/healthypets/images/pets/cute-dog-headshot.jpg',

        ),
      
      GestureDetector(
        onTap: (){},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ImageData(
          IconsPath.postMoreIcon,
          width: 30,
        ),),
      )
    ],
  ),);
}

Widget _image(){
  return CachedNetworkImage(imageUrl: 'https://img.freepik.com/premium-photo/a-drawing-of-a-baby-penguin-with-a-purple-and-blue-eyes_901003-49497.jpg?w=2000');
}

Widget _infoCount(){
 return Row(
  children: [
  Row(
    children: [
    const SizedBox(width:15),
    ImageData(
      IconsPath.likeOffIcon,
      width:65,
      ),

  ],
  )
 ],
 );
}
Widget _infoDescription(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal:15.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Text(
        '좋아요 150개',
        style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ExpandableText(
        '콘텐츠 1입니다\n콘텐츠 1입니다\n콘텐츠 1입니다\n콘텐츠 1입니다', 
        prefixText: 'YunaPark',
        onPrefixTap: (){
          print('마이페이지 이동');
        },
        prefixStyle: const TextStyle(fontWeight: FontWeight.bold),
        expandText: '더보기',
        collapseText: '접기',
        maxLines: 2,
        expandOnTextTap: true,
        collapseOnTextTap: true,
        linkColor: Colors.grey,
        //style: TextStyle(fontWeight: FontWeight.bold),
        ),
    ],
  ),);
}

Widget _dateAgo() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.0),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '1일전',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 11,
        ),
      ),
    ),
  );
}




 /*_header: 위에 아이디랑 프로필 뜨는거, _image: 이미지영역, _infocound: 좋아요영역, _infoDescription: 게시물내용영역 , _dateAgo: 며칠전껀지 영역 */
  @override
  Widget build(BuildContext context){
    return Container(
      margin:const EdgeInsets.only(top:20),
      child: Column(
        children: [
          _header(),
          const SizedBox(height: 15,),
          _image(),
          const SizedBox(height: 15,),
          _infoCount(),
           const SizedBox(height: 5,),
          _infoDescription(),
          const SizedBox(height: 5,),
          _dateAgo()
        ],
      ),
      //height:200,
      //width: 70,
      //color:Colors.red
    );
    
  }
}