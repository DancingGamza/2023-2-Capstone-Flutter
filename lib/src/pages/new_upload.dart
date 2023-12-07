import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';
import 'package:flutter_sns_form/src/app.dart';
class UploadDB extends StatefulWidget {
  @override
  _UploadDBState createState() => _UploadDBState();
}

class _UploadDBState extends State<UploadDB> {
  Dio dio = Dio();
  List<String> selectedImageUrls = [];
  List<List<Map<String, dynamic>>> animalData = [];
  //int maxImages = 0; // Variable to store the maximum number of images
  TextEditingController contentController = TextEditingController();
  List<int> selectedImageIds = []; // Change the type to store image IDs
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
  try {
    Dio dio = Dio();
    Response response = await dio.get(
      'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/animal/image/mylist',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        animalData = List<List<Map<String, dynamic>>>.from(response.data['data'].map<List<Map<String, dynamic>>>((item) {
          List<Map<String, dynamic>> itemList = List<Map<String, dynamic>>.from(item);
          for (Map<String, dynamic> imageInfo in itemList) {
            imageInfo['image'] = 'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com' + imageInfo['image'];
          }
          return itemList;
        }));

        // Dynamically set the maximum number of images based on the response
        //maxImages = 0;
        // for (List<Map<String, dynamic>> itemList in animalData) {
        //   maxImages += itemList.length;
        // }
      });
    } else {
      print("Failed to load data. Status code: ${response.statusCode}");
    }
  } catch (e) {
      print("Error fetching data: $e");
    }
  }

  int calculateTotalImages() {
    int totalImages = 0;
    for (List<Map<String, dynamic>> itemList in animalData) {
      totalImages += itemList.length;
    }
    return totalImages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          '올릴 이미지 선택',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'DungGeunMo',
            color: Color.fromARGB(138, 15, 179, 133),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              //child: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: calculateTotalImages(),
              itemBuilder: (context, index) {
                return buildImageWidget(index);
              },
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 111, 174, 186),
              ),
            ),
            onPressed: () {
              if (selectedImageIds.isNotEmpty) {
                showInputDialog(context);
              } else {
                print('Please select at least one image.');
              }
            },
            child: Text('다음', style: TextStyle(fontFamily: 'DungGeunMo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget buildImageWidget(int index) {
    if (index >= calculateTotalImages()) {
      return Container();
    }

    int currentCount = 0;
    for (int i = 0; i < animalData.length; i++) {
      if (currentCount + animalData[i].length > index) {
        int itemIndex = index - currentCount;
        int imageId = animalData[i][itemIndex]['id'];
        String imageUrl = animalData[i][itemIndex]['image'];

        return GestureDetector(
          onTap: () {
            setState(() {
              if (selectedImageIds.contains(imageId)) {
                selectedImageIds.remove(imageId);
              } else {
                if (selectedImageIds.length < 5) {
                  selectedImageIds.add(imageId);
                } else {
                  print('You can select up to 5 images.');
                }
              }
            });
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              selectedImageIds.contains(imageId)
                  ? Icon(
                      Icons.check_circle,
                      color: Color.fromARGB(138, 15, 179, 133),
                      size: 30.0,
                    )
                  : Container(),
            ],
          ),
        );
      }
      currentCount += animalData[i].length;
    }

    return Container();
  }

  void showInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('게시글 내용 입력', style: TextStyle(fontFamily: 'DungGeunMo')),
          content: TextField(
            controller: contentController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: '게시글 내용을 입력하세요',
              hintStyle: TextStyle(fontFamily: 'DungGeunMo'),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 111, 174, 186)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                postImagesAndContent();
              },
              child: Text('게시하기', style: TextStyle(fontFamily: 'DungGeunMo')),
            ),
          ],
        );
      },
    );
  }

  Future<void> postImagesAndContent() async {
    try {
      List<String> imageIds = [];
      for (int i = 0; i < selectedImageIds.length; i++) {
        int imageId = selectedImageIds[i];
        print('Selected image $i ID: $imageId');
        // Additional code as needed
      }

      Map<String, dynamic> formDataMap = {
        'content': contentController.text,
        'images': selectedImageIds,
      };

      FormData formData = FormData.fromMap(formDataMap);

      Response response = await dio.post(
        'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/post/create',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 201) {
        print(imageIds);
        print('Post successful');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const App(),
          ),
        );
      } else {
        print('Failed to post. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error posting data: $e');
    }
  }
}