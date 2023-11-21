import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageData extends StatelessWidget {
  String icon;
  final double? width;
  ImageData(
    this.icon,{
      Key? key,this.width=55,
      }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Image.asset(
      icon,
      width: width! / Get.mediaQuery.devicePixelRatio
      );
  }
}

class IconsPath {
  static String get personOff => 'assets/images/mine.jpg';
  static String get personOn => 'assets/images/mine_s.jpg';
  static String get homeOff => 'assets/images/newhome.jpg';
  static String get homeOn => 'assets/images/newhome_s.jpg';
  static String get searchOff => 'assets/images/magnifying.jpg';
  static String get searchOn => 'assets/images/magnifying_s.jpg';
  static String get uploadIcon => 'assets/images/uping.jpg';
  static String get activeOff => 'assets/images/paw.jpg';
  static String get activeOn => 'assets/images/paw_s.jpg';
  static String get logo => 'assets/images/logo.jpg';
  static String get mylogo => 'assets/images/bottom_nav_home_on_icon.jpg';
  static String get upsearch => 'assets/images/bottom_nav_search_on_icon.jpg';
  static String get upheart => 'assets/images/bottom_nav_active_on_icon.jpg';
  static String get upmine => 'assets/images/add_friend_icon.jpg';
  static String get upfootprint => 'assets/images/upfootprint.jpg';
  static String get directMessage => 'assets/images/direct_msg_icon.jpg';
  static String get plusIcon => 'assets/images/plus_icon.png';
  static String get postMoreIcon => 'assets/images/more_icon.jpg';
  static String get likeOffIcon => 'assets/images/like_off_icon.jpg';
  static String get likeOnIcon => 'assets/images/like_on_icon.jpg';
  static String get replyIcon => 'assets/images/reply_icon.jpg';
  static String get bookMarkOffIcon => 'assets/images/book_mark_off_icon.jpg';
  static String get bookMarkOnIcon => 'assets/images/book_mark_on_icon.jpg';
  static String get backBtnIcon => 'assets/images/back_icon.jpg';
  static String get menuIcon => 'assets/images/menu_icon.jpg';
  static String get addFriend => 'assets/images/add_friend_icon.jpg';
  static String get gridViewOff => 'assets/images/grid_view_off_icon.jpg';
  static String get gridViewOn => 'assets/images/grid_view_on_icon.jpg';
  static String get myTagImageOff => 'assets/images/my_tag_image_off_icon.jpg';
  static String get myTagImageOn => 'assets/images/my_tag_image_on_icon.jpg';
  static String get nextImage => 'assets/images/upload_next_icon.jpg';
  static String get closeImage => 'assets/images/close_icon.jpg';
  static String get imageSelectIcon => 'assets/images/image_select_icon.jpg';
  static String get cameraIcon => 'assets/images/camera_icon.jpg';
  static String get uploadComplete => 'assets/images/upload_complete_icon.jpg';
  static String get mypageBottomSheet01 =>
      'assets/images/mypage_bottom_sheet_01.jpg';
  static String get mypageBottomSheet02 =>
      'assets/images/mypage_bottom_sheet_02.jpg';
  static String get mypageBottomSheet03 =>
      'assets/images/mypage_bottom_sheet_03.jpg';
  static String get mypageBottomSheet04 =>
      'assets/images/mypage_bottom_sheet_04.jpg';
  static String get mypageBottomSheet05 =>
      'assets/images/mypage_bottom_sheet_05.jpg';
  static String get mypageBottomSheetSetting01 =>
      'assets/images/mypage_bottom_sheet_setting_01.jpg';
  static String get mypageBottomSheetSetting02 =>
      'assets/images/mypage_bottom_sheet_setting_02.jpg';
  static String get mypageBottomSheetSetting03 =>
      'assets/images/mypage_bottom_sheet_setting_03.jpg';
  static String get mypageBottomSheetSetting04 =>
      'assets/images/mypage_bottom_sheet_setting_04.jpg';
  static String get mypageBottomSheetSetting05 =>
      'assets/images/mypage_bottom_sheet_setting_05.jpg';
  static String get mypageBottomSheetSetting06 =>
      'assets/images/mypage_bottom_sheet_setting_06.jpg';
  static String get mypageBottomSheetSetting07 =>
      'assets/images/mypage_bottom_sheet_setting_07.jpg';
  static String get reportpet => 'assets/images/report_pet.jpg';
  static String get searchlostpet=> 'assets/images/search_lost_pet.jpg';
  static String get appbar=>'assets/images/app_bar.png';
  static String get mybar=>'assets/images/mybar.jpg';
  static String get mybar2=>'assets/images/mybar2.jpg';
  static String get mybar3=>'assets/images/mybar3.jpg';
  static String get mybar4=>'assets/images/mybar4.jpg';
  static String get toycam=>'assets/images/toycam.jpg';
  static String get toyspeaker=>'assets/images/toyspeaker.jpg';
  static String get mylist=>'assets/images/list.jpg';
  static String get dog1=>'assets/images/dog1.jpg';
  static String get dog2=>'assets/images/dog2.jpg';
  static String get paw=>'assets/images/papaw.jpg';
}