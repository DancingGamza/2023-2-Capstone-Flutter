import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum AvatarType {TYPE1,TYPE2,TYPE3}

class AvatarWidget extends StatelessWidget{
  String thumbPath; //프사 경로
  String? nickname; //닉네임
  AvatarType type;
  double? size;//동그란모양 아바타 크기

  AvatarWidget({
    Key? key,
    required this.thumbPath, 
    this. nickname,
    required this.type,
    this.size=65,
    }) : super(key:key);


    Widget type1Widget(){
      return Container(
        padding: const EdgeInsets.all(2),
        //width:65,
        //height:65,
        //margin
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end:Alignment.bottomLeft, 
            colors:[
             Colors.blue,
             Color.fromARGB(71, 9, 137, 196)],
            ), 
            shape:BoxShape.circle,
          ),
          child:Container(
            decoration:BoxDecoration(
              shape:BoxShape.circle,
              color: Colors.white,
              ),
          child: ClipRRect(
            borderRadius:BorderRadius.circular(size!),
            child: SizedBox(
            width:size,
            height:size,
            child: CachedNetworkImage(
              imageUrl : thumbPath, 
              fit : BoxFit.cover,
              ),
            ),
          ),
          ),
      );
    }

  Widget type2Widget() {
  return Row(
    children: [
      type1Widget(), // Display the avatar (You may want to adjust this part as needed)
      Text(
        nickname ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ],
  );
}




  @override
  Widget build(BuildContext context){
    switch (type) {
      case AvatarType.TYPE1:
        return type1Widget();
      case AvatarType.TYPE2:
        return type2Widget();
      case AvatarType.TYPE3:  
        return Container();
        break;
    }
  }
  
}