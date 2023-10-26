import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:flutter_sns_form/src/controller/bottom_nav_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_sns_form/src/pages/home.dart';
import 'package:flutter_sns_form/src/pages/search.dart';
import 'package:flutter_sns_form/src/pages/active_history.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Obx(
        () => Scaffold(
          backgroundColor: const Color.fromARGB(255, 44, 60, 143),
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              const Home(),
              const Search(),
              Container(),
              const ActiveHistory(),
              Container(child: Center(child: Text('MYPAGE'))),
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
                  icon: ImageData(IconsPath.homeOff),
                  activeIcon: ImageData(IconsPath.homeOn),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.searchOff),
                  activeIcon: ImageData(IconsPath.searchOn),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.uploadIcon),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.activeOff),
                  activeIcon: ImageData(IconsPath.activeOn),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 87, 65, 65),
                    ),
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
