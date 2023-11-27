import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:dio/dio.dart';
void main() {
  runApp(NewHome());
}

class NewHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        body: ListView(
          children: [
            HomeCard(
              userProfileImage: 'assets/images/dog1.jpg',
              username: 'yuna',
              postImages: [
                'assets/images/bbobbi18.jpg',
                'assets/images/bbobbi18.jpg',
                // Add more image paths as needed
              ],
              cardBackgroundImage: 'assets/images/pattern.JPG',
              likes: 30,
              postContent: '뽀삐뽀삐뽀 뽀삐뽀',
            ),
            SizedBox(height: 16),
            HomeCard(
              userProfileImage: 'assets/images/dog2.jpg',
              username: 'cjy',
              postImages: [
                'assets/images/fox7.jpg',
                'assets/images/fox7.jpg',
                // Add more image paths as needed
              ],
              cardBackgroundImage: 'assets/images/pattern.JPG',
              likes: 30,
              postContent: '여우여우여우영우',
            ),
            SizedBox(height: 16),
            HomeCard(
              userProfileImage: 'assets/images/dog3.jpg',
              username: 'james',
              postImages: [
                'assets/images/poppy2.jpg',
                'assets/images/poppy2.jpg',
                // Add more image paths as needed
              ],
              cardBackgroundImage: 'assets/images/pattern.JPG',
              likes: 30,
              postContent: '역시 시츄는 시츄',
            ),
            SizedBox(height: 16),
            HomeCard(
              userProfileImage: 'assets/images/dog4.jpg',
              username: 'doglover',
              postImages: [
                'assets/images/poppy.jpg',
                'assets/images/poppy.jpg',
                // Add more image paths as needed
              ],
              cardBackgroundImage: 'assets/images/pattern.JPG',
              likes: 30,
              postContent: '기여운 말티쮸',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatefulWidget {
  final String userProfileImage;
  final String username;
  final List<String> postImages; // Change to a list of image paths
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
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  PageController _pageController = PageController();
  bool isLiked = false;
  int likeCount = 0;

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
              backgroundImage: AssetImage(widget.userProfileImage),
            ),
            title: Text(widget.username, style: TextStyle(fontFamily: 'DungGeunMo')),
          ),
          SizedBox(
            height: 400, // Adjust the height according to your design
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.postImages.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  widget.postImages[index],
                  fit: BoxFit.cover, // Use BoxFit.cover to maintain aspect ratio and cover the entire square
                  width: double.infinity, // Make sure the image takes the entire width
                  height: double.infinity, // Make sure the image takes the entire height
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
                  icon: Image.asset(isLiked ? 'assets/images/liked_papaw.png' : 'assets/images/papaw.png', width: 50),
                  onPressed: () {
                    if (!isLiked) {
                      // Like button pressed
                      setState(() {
                        isLiked = true;
                        likeCount += 1;
                      });
                    }
                  },
                ),
                Text('$likeCount 발자국', style: TextStyle(fontFamily: 'DungGeunMo')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.postContent,
              style: TextStyle(fontSize: 16, fontFamily: 'DungGeunMo'),
            ),
          ),
        ],
      ),
    );
  }
}
