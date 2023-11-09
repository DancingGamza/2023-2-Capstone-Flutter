import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:flutter_sns_form/src/components/post_widget.dart';
import 'package:flutter_sns_form/src/pages/login.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final token1 = globalToken;

  List<Widget> generatePostList() {
    print(token1);
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
        actions: [],
      ),
      body: ListView(
        children: generatePostList(),
      ),
    );
  }
}
