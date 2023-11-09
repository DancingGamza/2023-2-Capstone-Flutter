import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';



class MypetList extends StatefulWidget {
  @override
  _MypetListState createState() => _MypetListState();
}

class _MypetListState extends State<MypetList> {
  final Dio dio = Dio();
  final String token = globalToken; // globalToken은 사용자의 토큰 값으로 적절한 곳에서 설정해야 합니다.
  String nicknamePet = '';

  @override
  void initState() {
    super.initState();
    requestAnimalInfo(token);
  }

  Future<void> requestAnimalInfo(String token) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    try {
      Response response = await dio.get('http://ec2-13-209-75-120.ap-northeast-2.compute.amazonaws.com/animal/mylist/');
      if (response.statusCode == 200) {
        print("Success: ${response.data}");
        var animalInfo = response.data;
        setState(() {
          var data = animalInfo['data'];
          nicknamePet = data[0]['nickname'];
        });
        // 이후 필요한 작업을 수행하실 수 있습니다.
      } else if (response.statusCode == 401) {
        print("Authentication Error: ${response.data}");
        // 인증 실패나 토큰 오류에 대한 처리를 여기에 추가하세요.
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void navigateToNextPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PetDetailsPage(nicknamePet: nicknamePet),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 펫 리스트'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
             onTap: navigateToNextPage, // 닉네임을 누르면 다음 페이지로 이동
              child: Text('동물 닉네임: $nicknamePet'),
            ),
          ],
        ),
      ),
    );
  }
}

class PetDetailsPage extends StatelessWidget {
  final String nicknamePet;

  PetDetailsPage({required this.nicknamePet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('동물 상세 정보'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('선택한 동물 닉네임: ${nicknamePet??"아직 등록된 동물이 없습니다"}'),
            // 이곳에 동물에 대한 상세 정보를 표시하는 위젯을 추가할 수 있습니다.
          ],
        ),
      ),
    );
  }
}
