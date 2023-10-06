import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/pages/upload.dart';
import 'package:get/get.dart';


class BottomNavController extends GetxController{
  RxInt pageIndex = 0.obs;

  List<int> bottomHistory =[0];

  void changeBottomNav(int value,{bool hasGesture = true}) {
    
    if(value ==0){
      //home event
      _changePage(value, hasGesture: hasGesture);
    }
    if(value ==1){
      //search event
      _changePage(value, hasGesture: hasGesture);
    }
    if(value ==2){
      //upload event
      Get.to(() => const Upload());
    }
    if(value ==3){
      //activity event
      _changePage(value, hasGesture: hasGesture);
    }
    if(value ==4){
      //mypage event
      _changePage(value, hasGesture: hasGesture);
    }
  }
  //upload제외새로운 페이지가 떠야행!
  void _changePage(int value,{bool hasGesture = true}){
      pageIndex(value);
      if (hasGesture ==false) return;
      if (bottomHistory.contains(value)){
        bottomHistory.remove(value);
      }
      bottomHistory.add(value);
      print(bottomHistory);
  }

  Future<bool> willPopAction() async{
    if (bottomHistory.length == 1){
      //showDiaglog(context: Get.context,builder:(context)=>MessagePopup())
      print('exit');
      return Future<bool>.value(true);
    }
    else{
      //bottomHistory.removeLast();
      bottomHistory.removeAt(bottomHistory.length -1);
      var index =bottomHistory.last;
      changeBottomNav(index,hasGesture: false);
      print('goto before page');
      print(bottomHistory);
      return Future<bool>.value(false);
    }
  }

}
