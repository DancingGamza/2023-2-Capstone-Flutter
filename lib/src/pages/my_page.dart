import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/fix_pet_list.dart';
import 'package:flutter_sns_form/src/pages/login.dart';
import 'package:flutter_sns_form/src/pages/fix_user_info.dart';
String globalUser = '';
String globalNumber = '';
String globalNickname = '';
int globalProfile=0;
bool globalConsent=false;
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
  int profile_number=1;
  bool personal_consent=false;
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
          'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/user/info');
      if (response.statusCode == 200) {
        print("$response");
        print("이건 성공");
        
        print("Success: ${response.data}");
        var userInfo = response.data;
        username = userInfo['data']['username'];
        globalUser = username;
        print("Success: $username");
        nickname = userInfo['data']['nickname'];
        globalNickname = nickname;
        phone_number = userInfo['data']['phone_number'];
        globalNumber = phone_number;
        register_date = userInfo['data']['register_date'];
        profile_number=userInfo['data']['profile_number'];
        globalProfile=profile_number;
        personal_consent=userInfo['data']['personal_consent'];
        globalConsent=personal_consent;
        // 이후 필요한 작업을 수행하실 수 있습니다.
      } else if (response.statusCode == 401) {
        print("Authentication Error: ${response.data}");
        // 인증 실패나 토큰 오류에 대한 처리를 여기에 추가하세요.
      }
    } catch (e) {
      
      print("이건 실패");
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfilePage(nickname:nickname,phoneNumber: phone_number,profilenumber:profile_number,personalconsent:personal_consent)),
                );
              },
              child: ProfileCard(),
            ),
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
                backgroundImage: AssetImage(getProfileImagePath(globalProfile)), // 프로필 사진의 URL을 넣어주세요.
              ),
              SizedBox(width: 16.0),
              // 프로필 정보
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Row(
                    children: [
                      Text(
                        'ID ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$globalUser',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        '이름 ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$globalNickname',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        '전화번호 ',
                        style: TextStyle
                          (color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$globalNumber',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  // 추가적인 정보를 표시할 수 있습니다.
                ],
              ),
              
            ],
          ),
        ));
  }
}

class PetCard extends StatefulWidget {
  @override
  _PetCardState createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  final dio2=Dio();
  List<String> nicknamePets = [];
  List<String> petchracteristics = [];
  List<String> mainimageUrls = [];
  List<String> animalids = [];

  @override
  void initState() {
    super.initState();
    animalinfo(token);
  }
  Future<void> animalinfo(String token) async {
    dio2.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    try {
      print("try해봄");
      Response response2 = await dio2.get(
          'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/animal/list');
      if (response2.statusCode == 200) {
        print("일단 200은 옴");
        print("Success: ${response2.data}");
        var animalInfo = response2.data;
        setState(() {
          var data1 = animalInfo['data'];
          nicknamePets = List<String>.from(
              data1.map((animal) => animal['nickname'].toString()));
          petchracteristics = List<String>.from(
              data1.map((animal) => animal['characteristic'].toString()));
          mainimageUrls = List<String>.from(
              data1.map((animal) => animal['main_img'].toString()));
          animalids =
              List<String>.from(data1.map((animal) => animal['id'].toString()));
        });
      } else if (response2.statusCode == 401) {
        print("Authentication Error: ${response2.data}");
        // Handle authentication errors or token issues here.
      }
    } catch (e) {
      
      print("Error: $e");
    }
  }




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
                // Check if the data is available
                if (nicknamePets.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: nicknamePets.length,
                    itemBuilder: (context, index) {
                      return PetAvatar(
                        petName: nicknamePets[index],
                        petImage: 'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/media/'+mainimageUrls[index],
                      );
                    },
                  ),
              ],
            ),
          ),
          Positioned(
            top: 20.0,
            right: 20.0,
            child: GestureDetector(
              onTap: () {
                print("펫 >이 눌림");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FixMypetList()),
                );
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
  final String? petImage;

  PetAvatar({required this.petName, required this.petImage});

  @override
  Widget build(BuildContext context) {
    bool isDefaultImage = petImage == null ||
        petImage == 'http://ec2-3-39-24-207.ap-northeast-2.compute.amazonaws.com/media/';

    return Column(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundImage: isDefaultImage
              ? Image.asset('assets/images/unknowndog.png').image
              : Image.network(petImage!).image,
        ),
        SizedBox(height: 5.0),
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