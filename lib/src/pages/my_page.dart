import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';

String globalUser = '';
String globalNumber = '';
String globalNickname = '';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final dio = Dio();

  var username = '';
  var nickname = '';
  var phone_number = '';
  var register_date = '';

  @override
  void initState() {
    super.initState();
    requestUserInfo(token);
  }

  Future<void> requestUserInfo(String token) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    try {
      Response response = await dio.get(
          'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/users/info/');
      if (response.statusCode == 200) {
        print("Success: ${response.data}");
        var userInfo = response.data;
        username = userInfo['username'];
        globalUser = username;
        print("Success: $username");
        nickname = userInfo['nickname'];
        globalNickname = nickname;
        phone_number = userInfo['phone_number'];
        globalNumber = phone_number;
        register_date = userInfo['register_date'];
        // 이후 필요한 작업을 수행하실 수 있습니다.
      } else if (response.statusCode == 401) {
        print("Authentication Error: ${response.data}");
        // 인증 실패나 토큰 오류에 대한 처리를 여기에 추가하세요.
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: ImageData(IconsPath.upmine, width: 400),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(),
            SizedBox(height: 16.0),
            PetCard(),
            SizedBox(height: 16.0),
            // 로그아웃과 개발자 정보
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // 로그아웃을 수행할 함수 호출
                      onLogout();
                    },
                    child: Text(
                      '로그아웃',
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  GestureDetector(
                    onTap: () {
                      // 개발자 정보 메시지 박스 표시
                      onDeveloperInfo(context);
                    },
                    child: Text(
                      '개발자 정보',
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 로그아웃 함수
  void onLogout() {
    // 여기에 로그아웃 시 수행할 동작 추가
    token = '';
    globalToken = '';
    globalNickname = '';
    globalNumber = '';
    globalUser = '';
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LogingIn(),
      ),
    );
    print('로그아웃 수행');
  }

  // 개발자 정보 표시 함수
  void onDeveloperInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('개발자 정보'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('프론트: 박유나 \nrealyuna@cau.ac.kr'),
                Text('\n'),
                Text('백엔드,AI: 최재영 antjqwydld@naver.com'),
                Text('\n'),
                Text('발표,보고서: 이재민 james9589@naver.com'),
                // 원하는 개발자 정보를 추가할 수 있습니다.
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text('닫기'),
            ),
          ],
        );
      },
    );
  }
}

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        color: Color.fromARGB(255, 111, 174, 186),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // 프로필 사진
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://i.namu.wiki/i/I8KKi13EBp0nUnliM4RrrNfp_MGruxcCsLkdHPIB2HsJRSWHGs3qyJCs4w9x98kHTuIZYqOl39RsLr_GK_iGdQ.webp'), // 프로필 사진의 URL을 넣어주세요.
              ),
              SizedBox(width: 16.0),
              // 프로필 정보
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   '프로필 정보',
                  //   style: TextStyle(
                  //     fontSize: 20.0,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  SizedBox(height: 8.0),
                  // 여기에 프로필 정보를 나타내는 위젯들을 추가하세요.
                  Text('ID: $globalUser'),
                  Text('이름: $globalNickname'),
                  Text('전화번호: $globalNumber'),
                  // 추가적인 정보를 표시할 수 있습니다.
                ],
              ),
              //),
              // SizedBox(width: 90.0),
              // // '>' 버튼
              // Positioned(
              //   top: 100.0, // 원하는 위치 조절
              //   right: 100.0, // 원하는 위치 조절
              //   child: GestureDetector(
              //     onTap: () {
              //       // '>' 버튼을 눌렀을 때 프로필 수정 페이지로 이동
              //       // Navigator.push(
              //       //   context,
              //       //   MaterialPageRoute(builder: (context) => ProfileEditPage()),
              //       // );
              //       print(">눌림2");
              //     },
              //     child: Icon(Icons.arrow_forward),
              //   ),
              // ),
            ],
          ),
        ));
  }
}

class PetCard extends StatelessWidget {
  final List<Map<String, dynamic>> pets = [
    {
      'name': 'Buddy',
      'image':
          'https://i.namu.wiki/i/I8KKi13EBp0nUnliM4RrrNfp_MGruxcCsLkdHPIB2HsJRSWHGs3qyJCs4w9x98kHTuIZYqOl39RsLr_GK_iGdQ.webp'
    },
    {
      'name': 'Charlie',
      'image':
          'https://i.namu.wiki/i/I8KKi13EBp0nUnliM4RrrNfp_MGruxcCsLkdHPIB2HsJRSWHGs3qyJCs4w9x98kHTuIZYqOl39RsLr_GK_iGdQ.webp'
    },
    // 다른 동물에 대한 정보를 추가할 수 있습니다.
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Color.fromARGB(255, 111, 174, 186),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '반려동물 정보 등록',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                // 그리드 뷰로 동물 정보를 표시
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, // 한 줄에 다섯 마리의 동물을 표시
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    return PetAvatar(
                      petName: pets[index]['name'],
                      petImage: pets[index]['image'],
                    );
                  },
                ),
              ],
            ),
          ),
          // '>' 버튼
          Positioned(
            top: 20.0, // 원하는 위치 조절
            right: 20.0, // 원하는 위치 조절
            child: GestureDetector(
              onTap: () {
                print("펫 >이 눌림");
                // '>' 버튼을 눌렀을 때 프로필 수정 페이지로 이동
                // Navigator.push(
                // //   context,
                // //   MaterialPageRoute(builder: (context) => PetEditPage()),

                // );
              },
              child: Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }
}

class PetAvatar extends StatelessWidget {
  final String petName;
  final String petImage;

  PetAvatar({required this.petName, required this.petImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 동물 사진
        CircleAvatar(
          radius: 20.0,
          backgroundImage: NetworkImage(petImage), // 동물 사진의 URL을 넣어주세요.
        ),
        SizedBox(height: 5.0),
        // 동물 이름
        Flexible(
          child: Text(
            petName,
            style: TextStyle(fontSize: 12.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
