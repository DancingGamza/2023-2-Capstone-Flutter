import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:flutter_sns_form/src/controller/bottom_nav_controller.dart';
import 'package:get/get.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return WillPopScope(
      child: Obx(()=>Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: IndexedStack(
          index:controller.pageIndex.value,
          children: [
            Container(child: Text('HOME'),),
            Container(child: Text('SEARCH'),),
            Container(child: Center(child: Text('UPLOAD')),),
            Container(child: Center(child: Text('ACTIVITY')),),
            Container(child: Center(child: Text('MYPAGE')),),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, //눌렀을때 위로 올라가는 현상없앰
          showSelectedLabels: false,
          showUnselectedLabels: false,
          //backgroundColor: Colors.red, 밑에 바 색깔 바꾸는것
          currentIndex: controller.pageIndex.value,
          elevation: 0, //밑에 바가 약간 떠있는 느낌 그림자 이런걸 없애줌
          onTap:controller.changeBottomNav,
          items: [
          BottomNavigationBarItem(
            //icon: Image.asset('assets/images/add_friend_icon.jpg'),
            icon: ImageData(IconsPath.homeOff),
            activeIcon: ImageData(IconsPath.homeOn),
            label: 'home',
            ),
          BottomNavigationBarItem(
            //icon: Image.asset('assets/images/add_friend_icon.jpg'),
            icon: ImageData(IconsPath.searchOff),
            activeIcon: ImageData(IconsPath.searchOn),
            label: 'home',
            ),
          BottomNavigationBarItem(
            //icon: Image.asset('assets/images/add_friend_icon.jpg'),
            icon: ImageData(IconsPath.uploadIcon),
            label: 'home',
            ),
          BottomNavigationBarItem(
            //icon: Image.asset('assets/images/add_friend_icon.jpg'),
            icon: ImageData(IconsPath.activeOff),
            activeIcon: ImageData(IconsPath.activeOn),
            label: 'home',
            ),
          BottomNavigationBarItem(
            //icon: Image.asset('assets/images/add_friend_icon.jpg'),
            icon: Container(
            width:30,
            height:30,
            decoration:
            const BoxDecoration(
              shape:BoxShape.circle,color:Colors.grey,
              ),
             ),
              label: 'home',
            ),  
          ],
        ),
      ),
      ), 
      onWillPop: controller.willPopAction
    );
  }
}