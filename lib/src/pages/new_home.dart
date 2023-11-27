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
    const String apiUrl = 'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/post/feed';
    final Dio dio = Dio();

    try {
      print("Fetching data...");
      Response response = await dio.get(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

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
            return HomeCard(postData: postData[index]);
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
  final UserData user;

  PostData({
    required this.likeCount,
    required this.content,
    required this.images,
    required this.user,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      likeCount: json['post']['like_count'],
      content: json['post']['content'],
      images: json['images'].map<String>((image) {
        return 'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com' + image['image'];
      }).toList(),
      user: UserData.fromJson(json['user']),
    );
  }
}

class UserData {
  final String username;
  final String? profileImage;

  UserData({
    required this.username,
    this.profileImage,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      username: json['username'],
      profileImage: json['profile_image'],
    );
  }
}

class HomeCard extends StatelessWidget {
  final PostData postData;

  HomeCard({required this.postData});

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
              backgroundImage: AssetImage(postData.user.profileImage ?? 'assets/images/dog3.jpg'),
            ),
            title: Text(postData.user.username),
          ),
          SizedBox(
            height: 400,
            child: PageView.builder(
              itemCount: postData.images.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  postData.images[index],
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
                Text('${postData.likeCount} 발자국'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              postData.content,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}