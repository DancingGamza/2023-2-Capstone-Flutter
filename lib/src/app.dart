import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:flutter_sns_form/src/controller/bottom_nav_controller.dart';
import 'package:flutter_sns_form/src/pages/new_home.dart';
import 'package:flutter_sns_form/src/pages/new_upload.dart';

import 'package:get/get.dart';
import 'package:flutter_sns_form/src/pages/home.dart';
import 'package:flutter_sns_form/src/pages/search.dart';
import 'package:flutter_sns_form/src/pages/active_history.dart';
import 'package:flutter_sns_form/src/pages/my_page.dart';
import 'package:flutter_sns_form/src/pages/login.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Obx(
        () => Scaffold(
          
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: IndexedStack(
            
            index: controller.pageIndex.value,
            children: [
              NewHome(),
              const Search(),
              UploadDB(),
              //Container(),
              ActiveHistory1(),
              MyPage(),
              //Container(child: Center(child: Text('MYPAGE'))),
            ],
          ),
          bottomNavigationBar: ClipRRect( // Wrap the AppBar with ClipRRect
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), // Adjust the radius as needed
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: controller.pageIndex.value,
              elevation: 0,
              onTap: controller.changeBottomNav,
              items: [
                BottomNavigationBarItem(
  icon: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/newhome.jpg'),
        fit: BoxFit.contain, // 이미지를 컨테이너에 맞게 조절합니다.
      ),
    ),
    width: 30.0, // 조절하고자 하는 크기로 설정
    height: 30.0, // 조절하고자 하는 크기로 설정
  ),
  activeIcon: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/newhome_s.jpg'),
        fit: BoxFit.contain,
      ),
    ),
    width: 30.0, // 조절하고자 하는 크기로 설정
    height: 30.0, // 조절하고자 하는 크기로 설정
  ),
  label: 'home',
),
                 BottomNavigationBarItem(
  icon: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/magnifying.jpg'),
        fit: BoxFit.contain, // 이미지를 컨테이너에 맞게 조절합니다.
      ),
    ),
    width: 30.0, // 조절하고자 하는 크기로 설정
    height: 30.0, // 조절하고자 하는 크기로 설정
  ),
  activeIcon: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/magnifying_s.jpg'),
        fit: BoxFit.contain,
      ),
    ),
    width: 30.0, // 조절하고자 하는 크기로 설정
    height: 30.0, // 조절하고자 하는 크기로 설정
  ),
  label: 'home',
),
                 BottomNavigationBarItem(
  icon: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/uping.jpg'),
        fit: BoxFit.contain, // 이미지를 컨테이너에 맞게 조절합니다.
      ),
    ),
    width: 30.0, // 조절하고자 하는 크기로 설정
    height: 30.0, // 조절하고자 하는 크기로 설정
  ),
  // activeIcon: Container(
  //   decoration: BoxDecoration(
  //     image: DecorationImage(
  //       image: AssetImage('assets/images/newhome_s.jpg'),
  //       fit: BoxFit.contain,
  //     ),
  //   ),
  //   width: 30.0, // 조절하고자 하는 크기로 설정
  //   height: 30.0, // 조절하고자 하는 크기로 설정
  // ),
  label: 'home',
),
                 BottomNavigationBarItem(
  icon: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/paw.jpg'),
        fit: BoxFit.contain, // 이미지를 컨테이너에 맞게 조절합니다.
      ),
    ),
    width: 30.0, // 조절하고자 하는 크기로 설정
    height: 30.0, // 조절하고자 하는 크기로 설정
  ),
  activeIcon: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/paw_s.jpg'),
        fit: BoxFit.contain,
      ),
    ),
    width: 30.0, // 조절하고자 하는 크기로 설정
    height: 30.0, // 조절하고자 하는 크기로 설정
  ),
  label: 'home',
),
                 BottomNavigationBarItem(
  icon: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/mine.jpg'),
        fit: BoxFit.contain, // 이미지를 컨테이너에 맞게 조절합니다.
      ),
    ),
    width: 30.0, // 조절하고자 하는 크기로 설정
    height: 30.0, // 조절하고자 하는 크기로 설정
  ),
  activeIcon: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/mine_s.jpg'),
        fit: BoxFit.contain,
      ),
    ),
    width: 30.0, // 조절하고자 하는 크기로 설정
    height: 30.0, // 조절하고자 하는 크기로 설정
  ),
  label: 'home',
),
              ],
            ),
          ),
        ),
      ),
      onWillPop: controller.willPopAction,
    );
  }
}
