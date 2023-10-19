import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/components/image_data.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
class Upload extends StatefulWidget{
  const Upload({Key?key}):super(key: key);
  @override
  State<Upload> createState() => _UploadState();
}




class _UploadState extends State<Upload>{
var albums=<AssetPathEntity>[];
var imageList=<AssetEntity>[];
var headerTitle='';
AssetEntity? selectedImage;

@override
void initState(){
  super.initState();
  _loadPhotos();
}

void _loadPhotos()async{
  var result= await PhotoManager.requestPermissionExtend();
  if (result.isAuth){
    albums=await PhotoManager.getAssetPathList(
      type: RequestType.image,
      filterOption: FilterOptionGroup(
        imageOption:const FilterOption(
          sizeConstraint:SizeConstraint(minHeight: 100, minWidth:100,),
          ),
          orders: [
            const OrderOption(type:OrderOptionType.createDate,asc:false),
          ]
          ),
          );
          _loadData();
  }else{
    //권한요청
  }
}


void _loadData()async{
  headerTitle=albums.first.name;
  await _pagingPhotos();
  update();
}

Future<void> _pagingPhotos()async{
 var photos= await albums.first.getAssetListPaged(page: 0, size: 30);
 imageList.addAll(photos);
 selectedImage =imageList.first;
}



void update() => setState((){});

Widget _imagePreview(){
  return Container(
    width:MediaQuery.of(context).size.width,
    height:MediaQuery.of(context).size.width,
    color:Colors.grey,
    child:selectedImage==null
    ?Container()
    :FutureBuilder(
      future: selectedImage!.thumbnailDataWithSize(
      ThumbnailSize(MediaQuery.of(context).size.width.toInt(), MediaQuery.of(context).size.width.toInt())), 
      builder: (_,AsyncSnapshot<Uint8List?> snapshot){
        if (snapshot.hasData){
          
          return Image.memory(
            snapshot.data!,
            fit:BoxFit.cover,
            );
        }else{
          return Container();
        }
      },),
    );
}

Widget _header() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children:  [
              Text(
                headerTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              //Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xff808080),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  ImageData(IconsPath.imageSelectIcon),
                  const SizedBox(width: 7),
                  const Text(
                    '여러항목 선택',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff808080),
              ),
              child: ImageData(IconsPath.cameraIcon),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _imageSelectList() {
  return GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      childAspectRatio: 1,
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
    ),
    itemCount: imageList.length,
    itemBuilder: (BuildContext context, int index) {
      final asset = imageList[index];
      return _photoWidget(asset, 200);
    },
  );
}

Widget _photoWidget(AssetEntity asset, int size) {
  return GestureDetector(
    onTap: () {
      setState(() {
        selectedImage = asset;
      });
    },
    child: FutureBuilder(
      future: asset.thumbnailDataWithSize(ThumbnailSize(size, size)),
      builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          return Opacity(
            opacity: asset == selectedImage ? 0.3 : 1,
            child: Image.memory(
              snapshot.data!,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return Container();
        }
      },
    ),
  );
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 60, 143),
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 44, 60, 143),
        elevation:0,
        leading:GestureDetector(
          onTap: Get.back,
          child: Padding(padding: const EdgeInsets.all(15.0),
          child: ImageData(IconsPath.closeImage),
          ),
        ),
        title : const Text(
          'New Post',
          style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
        ),
        actions: [
          GestureDetector(
            onTap:(){},
            child: Padding(padding: const EdgeInsets.all(15.0),
            child: ImageData(IconsPath.nextImage,width:50),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(child: Column(children: [
        _imagePreview(),
        _header(),
        _imageSelectList(),
      ],
      ),
      ),
    );
  }
}