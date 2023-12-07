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
    const String apiUrl = 'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/post/feed';
    final Dio dio = Dio();

    try {
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
  int likeCount;
  final String content;
  final List<String> images;
  final UserData user;
  final int postId;

  PostData({
    required this.likeCount,
    required this.content,
    required this.images,
    required this.user,
    required this.postId,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      likeCount: json['post']['like_count'],
      content: json['post']['content'],
      images: json['images'].map<String>((image) {
        return 'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com' + image['image'];
      }).toList(),
      user: UserData.fromJson(json['user']),
      postId: json['post']['id'],
    );
  }
}

class UserData {
  final String username;
  final int? profileNumber;

  UserData({
    required this.username,
    this.profileNumber,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      username: json['username'],
      profileNumber: json['profile_number'],
    );
  }
}

String getProfileImagePath(int profileNumber) {
  switch (profileNumber) {
    case 1:
      return 'assets/images/mydog1.png';
    case 2:
      return 'assets/images/mydog2.png';
    case 3:
      return 'assets/images/mydog3.png';
    case 4:
      return 'assets/images/mydog4.png';
    default:
      return 'assets/images/mydog1.png'; // Add a default image path if needed
  }
}

class HomeCard extends StatefulWidget {
  final PostData postData;

  HomeCard({required this.postData});

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool isLiked = false;

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
              backgroundImage:
                  AssetImage(getProfileImagePath(widget.postData.user.profileNumber ?? 1)),
            ),
            title: Text(widget.postData.user.username,style:TextStyle(fontFamily: 'DungGeunMo')),
          ),
          SizedBox(
            height: 400,
            child: PageView.builder(
              itemCount: widget.postData.images.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  widget.postData.images[index],
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
                  icon: Image.asset(
                    isLiked
                        ? 'assets/images/liked_papaw.png'
                        : 'assets/images/papaw.png',
                    width: 50,
                  ),
                  onPressed: () {
                    toggleLikeStatus(widget.postData.postId);
                  },
                ),
                Text('${widget.postData.likeCount} 발자국',style: TextStyle(fontFamily:'DungGeunMo' ),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.postData.content,
              style: TextStyle(fontSize: 16,fontFamily: 'DungGeunMo'),
            ),
          ),
        ],
      ),
    );
  }

  void toggleLikeStatus(int postId) async {
    try {
      final String apiUrl =
          'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/post/like/$postId';
      final Dio dio7 = Dio();

      Response response = await dio7.get(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("좋아요버튼갑니다");
        setState(() {
          isLiked = !isLiked;
          if (isLiked) {
            widget.postData.likeCount++;
          } else {
            widget.postData.likeCount--;
          }
        });
      } else {
        print('Error toggling like status: ${response.statusCode}');
        // Handle error as needed
      }
    } catch (e) {
      print('Error toggling like status: $e');
      // Handle error as needed
    }
  }
}
