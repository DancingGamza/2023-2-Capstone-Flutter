import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/components/avatar_widget.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:flutter_sns_form/src/pages/login.dart';
class ActiveHistory1 extends StatefulWidget {
  const ActiveHistory1({Key? key}) : super(key: key);

  @override
  _ActiveHistory1State createState() => _ActiveHistory1State();
}

class _ActiveHistory1State extends State<ActiveHistory1> {
  late Dio dio;

  @override
  void initState() {
    super.initState();
    dio = Dio();
    // Set up Dio options if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: ImageData(IconsPath.upfootprint, width: 200),
      ),
      body: FutureBuilder<Response>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Parse the response and dynamically create cards
            List<Widget> cards = _buildCards(snapshot.data!);
            return SingleChildScrollView(
              child: Column(
                children: cards,
              ),
            );
          }
        },
      ),
    );
  }

  Future<Response> fetchData() async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      };
      return await dio.get('http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/post/alarm/list');
    } catch (e) {
      throw e;
    }
  }

  List<Widget> _buildCards(Response response) {
    List<Map<String, dynamic>> data = List.castFrom(response.data['data']);

    return data.map((item) {
      // Customize this part based on your data structure
      int id = item['id'];
      String username = item['register_username'];
      String message = item['alarm_message'];
      String date = item['register_date'];
      int contentType = item['content_type'];
      int contentId = item['content_id'];

      return _buildCard(id, username, message, date, contentType, contentId);
    }).toList();
  }

  Widget _buildCard(int id, String username, String message, String date, int contentType, int contentId) {
    return GestureDetector(
      onTap: () async {
        // Fetch additional information based on content type
        Response additionalInfoResponse = await fetchAdditionalInfo(contentType, id);

        // Show message box when the card is tapped
        _showMessageBox(contentType, additionalInfoResponse);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage('assets/images/mybar4.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/footprint.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        message,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Response> fetchAdditionalInfo(int contentType, int id) async {
    try {dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };
      return await dio.get('http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/post/alarm/$id');
    } catch (e) {
      throw e;
    }
  }
void _showMessageBox(int contentType, Response additionalInfoResponse) {
  String messageType;
  String title;
  List<Widget> contentWidgets = [];

  if (contentType == 1) {
    messageType = '실종신고!';
    title = '실종신고 알림';
    contentWidgets = _buildMissingContent(additionalInfoResponse.data['data']);
  } else if (contentType == 2) {
    messageType = '제보 들어옴!';
    title = '제보 알림';
    contentWidgets = _buildReportContent(additionalInfoResponse.data['data']);
  } else {
    return; // Do nothing for other content types
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(messageType),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            SizedBox(height: 10),
            // Use contentWidgets directly
            ...contentWidgets,
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('닫기'),
          ),
        ],
      );
    },
  );
}
List<Widget> _buildMissingContent(Map<String, dynamic> data) {
  // Customize the content based on your data structure
  String imageUrl = 'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/media/' + data['main_img'];
  String nickname = data['nickname'];
  String location = data['location'];
  String phoneNumber = data['phone_number'];
  String characteristic = data['characteristic'] ?? ''; // Handle null characteristic
  if (data['characteristic']==''){
    characteristic='x';
  }
  if (data['phone_number']==''){
    phoneNumber='비공개';
  }
  return [
    Image.network(imageUrl), // Display image using Image.network
    Text(' '),
    Text('동물 이름 :   $nickname'),
    Text(' '),
    Text('실종 위치 :   $location'),
    Text(' '),
    Text('주인 번호 :   $phoneNumber'),
    Text(' '),
    Text('특징 :   $characteristic'),
  ];
}

List<Widget> _buildReportContent(Map<String, dynamic> data) {
  // Customize the content based on your data structure
  String imageUrl = 'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/media/' + data['main_img'];
  String nickname = data['nickname'];
  String location = data['location'];
  String phoneNumber = data['phone_number'];
  if (data['phone_number']==''){
    phoneNumber='비공개';
  }
  return [
    Image.network(imageUrl),
    Text(' '), // Display image using Image.network
    Text('동물 이름 :   $nickname'),
    Text(' '),
    Text('발견 위치 :   $location'),
    Text(' '),
    Text('제보자 번호 :   $phoneNumber'),
  ];
}}