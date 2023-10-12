import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:flutter_sns_form/src/components/post_widget.dart';
class Home extends StatelessWidget {
  const Home({Key?key}):super(key: key);

  Widget _postList(){
    return Column(
      children: List.generate(50,(index) => PostWidget()).toList(),
    );
  }
  




  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: ImageData(IconsPath.mylogo,width:270),
        actions: [],

        ),
        body:ListView(children:[_postList()],)
    );
  }
  
}