import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_sns_form/src/pages/login.dart';
void main() {
  runApp(NewHome());
}

class NewHome extends StatefulWidget {
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  List<PostData> postData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const  String apiUrl = 'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/post/feed';
    final Dio dio = Dio();

    try {
      print("new home try는 들어옴");
      Response response = await dio.get(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
          },
        ),
      );
    print("try위에 수정");
      Map<String, dynamic> responseData = json.decode(response.toString());

      List<dynamic> posts = responseData['data'];
      List<PostData> tempData = posts.map((post) => PostData.fromJson(post)).toList();

      setState(() {
        postData = tempData;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: postData.length,
          itemBuilder: (BuildContext context, int index) {
            return HomeCard(
              userProfileImage: 'assets/images/dog3.jpg',
              username: 'yunna',
              postImages: postData[index].images,
              cardBackgroundImage: 'assets/images/pattern.JPG',
              likes: postData[index].likeCount,
              postContent: postData[index].content,
            );
          },
        ),
      ),
    );
  }
}

class PostData {
  final int likeCount;
  final String content;
  final List<String> images;
  final String registerId;
  final String registerDate;

  PostData({
    required this.likeCount,
    required this.content,
    required this.images,
    required this.registerId,
    required this.registerDate,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      likeCount: json['post']['like_count'],
      content: json['post']['content'],
      images: json['images'].map<String>((image) {
        return 'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com' + image['image'];
      }).toList(),
      registerId: json['post']['register_id'],
      registerDate: json['post']['register_date'],
    );
  }
}

class HomeCard extends StatelessWidget {
  final String userProfileImage;
  final String username;
  final List<String> postImages;
  final String cardBackgroundImage;
  final int likes;
  final String postContent;

  HomeCard({
    required this.userProfileImage,
    required this.username,
    required this.postImages,
    required this.cardBackgroundImage,
    required this.likes,
    required this.postContent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(userProfileImage),
            ),
            title: Text(username),
          ),
          SizedBox(
            height: 400,
            child: PageView.builder(
              itemCount: postImages.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  postImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Image.asset('assets/images/liked_papaw.png', width: 50),
                  onPressed: () {
                    // Handle like button pressed
                  },
                ),
                Text('$likes 발자국'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              postContent,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}