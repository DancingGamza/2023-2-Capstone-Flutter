import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
void main() {
  runApp(NewHome());
}

class NewHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //backgroundColor: Colors.white,
        //backgroundColor: Color.fromARGB(138, 15, 179, 133) ,
       /*appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/images/bottom_nav_home_on_icon.jpg', width: 270),
        ),*/
        body: ListView(
          children: [
            HomeCard(
              cardBackgroundImage: 'assets/images/dulicard.jpg',
              userProfileImage: 'assets/images/dog1.jpg',
              username: 'yuna',
              postImage: 'assets/images/bbobbi18.jpg',
              likes: 30,
              postContent: 'Beautiful sunset! 🌅',
              onLikePressed: () {
                print('Like button pressed for post 1!');
              },
            ),
            SizedBox(height: 16),
            HomeCard(
              cardBackgroundImage: 'assets/images/dulicard.jpg',
              userProfileImage: 'assets/images/dog2.jpg',
              username: 'cjy',
              postImage: 'assets/images/fox7.jpg',
              likes: 20,
              postContent: 'Exploring new places! 🗺️',
              onLikePressed: () {
                print('Like button pressed for post 2!');
              },
            ),
            SizedBox(height: 16),
            HomeCard(
              cardBackgroundImage: 'assets/images/dulicard.jpg',
              userProfileImage: 'assets/images/dog3.jpg',
              username: 'james',
              postImage: 'assets/images/poppy2.jpg',
              likes: 15,
              postContent: 'Delicious food! 🍕',
              onLikePressed: () {
                print('Like button pressed for post 3!');
              },
            ),
            SizedBox(height: 16),
            HomeCard(
              cardBackgroundImage: 'assets/images/dulicard.jpg',
              userProfileImage: 'assets/images/dog4.jpg',
              username: 'doglover',
              postImage: 'assets/images/poppy.jpg',
              likes: 25,
              postContent: 'Chilling at the beach! 🏖️',
              onLikePressed: () {
                print('Like button pressed for post 4!');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String userProfileImage;
  final String username;
  final String postImage;
  final String cardBackgroundImage;
  final int likes;
  final String postContent;
  final VoidCallback onLikePressed;

  HomeCard({
    required this.userProfileImage,
    required this.username,
    required this.postImage,
    required this.cardBackgroundImage,
    required this.likes,
    required this.postContent,
    required this.onLikePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color:Color.fromARGB(255, 240, 237, 201),
      clipBehavior: Clip.antiAlias,
      child: Stack( // Use Stack instead of Column
        children: [
          // Image.asset(
          //   cardBackgroundImage,
          //   fit: BoxFit.cover,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(userProfileImage),
                ),
                title: Text(username),
              ),
              Image.asset(
                postImage,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                       icon: Image.asset('assets/images/papaw.png', width: 50),
                      onPressed: onLikePressed,
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
        ],
      ),
    );
  }
}
