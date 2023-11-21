
import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:flutter_sns_form/src/components/post_widget.dart';
import 'package:flutter_sns_form/src/pages/login.dart';
import 'package:dio/dio.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final token1 = globalToken;
  
  Future<void> requestFeed() async {
    final dio = Dio();
    String imageUrl = '';
    String content = '';

    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    try {
      Response response = await dio.get(
          'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/posts/feeds/');
      if (response.statusCode == 200) {
        setState(() {
          for(var feed in response.data['feeds']){
            var post = feed['post'];
            content = post['content'];
            imageUrl = "http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/media/" + post['main_img'];
            //print(imageUrl);
            //print(content);
          }
        });
        // You can perform additional tasks with 'animalInfo' here.
      } else if (response.statusCode == 401) {
        //print("Authentication Error: ${response.data}");
        // Handle authentication error or token issues here.
      }
    } catch (e) {
      //print("Error: $e");
    }
  }

  List<Widget> generatePostList() {
    requestFeed();
    //print(token1);
    // Generate a list of PostWidget instances.
    List<Widget> posts = List.generate(50, (index) {
      return PostWidget(token: token1); // Pass your token here.
    });

    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: ImageData(IconsPath.mylogo, width: 270),
        //actions: [],
      ),
      body: ListView(
        children: generatePostList(),
      ),
    );
  }
}
