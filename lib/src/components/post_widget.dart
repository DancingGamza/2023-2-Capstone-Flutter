import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/avatar_widget.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';

class PostWidget extends StatefulWidget {
  //final String token;
  var token=globalToken;
  PostWidget({Key? key, required this.token}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final dio = Dio();
  String imageUrl = '';
  var animalInfo;

  @override
  void initState() {
    super.initState();
    requestUserInfo(widget.token);
    print(token);
  }

  Future<void> requestUserInfo(String token) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    try {
      Response response = await dio.get(
          'http://ec2-13-209-75-120.ap-northeast-2.compute.amazonaws.com/animal/info/1');
      if (response.statusCode == 200) {
        print("Success: ${response.data}");
        setState(() {
          print("데이터들어옴");
          animalInfo = response.data;
          imageUrl = "http://ec2-13-209-75-120.ap-northeast-2.compute.amazonaws.com/media/" +animalInfo['data']['main_img'];
          print(imageUrl);
        });
        // You can perform additional tasks with 'animalInfo' here.
      } else if (response.statusCode == 401) {
        print("Authentication Error: ${response.data}");
        // Handle authentication error or token issues here.
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AvatarWidget(
            type: AvatarType.TYPE2,
            nickname: ' YunaPark',
            size: 40,
            thumbPath: //imageUrl,
                'https://www.cdc.gov/healthypets/images/pets/cute-dog-headshot.jpg',
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageData(
                IconsPath.postMoreIcon,
                width: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return CachedNetworkImage(imageUrl: imageUrl);
  }

  Widget _infoCount() {
    return Row(
      children: [
        Row(
          children: [
            const SizedBox(width: 15),
            ImageData(
              IconsPath.likeOffIcon,
              width: 65,
            ),
          ],
        )
      ],
    );
  }

  Widget _infoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
            onPrefixTap: () {
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
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          _header(),
          const SizedBox(height: 15),
          _image(),
          const SizedBox(height: 15),
          _infoCount(),
          const SizedBox(height: 5),
          _infoDescription(),
          const SizedBox(height: 5),
          _dateAgo(),
        ],
      ),
    );
  }
}
