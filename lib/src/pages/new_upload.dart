import 'package:flutter/material.dart';

void main() {
  runApp(UploadDB());
}

class UploadDB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageSelectionScreen(),
    );
  }
}

class ImageSelectionScreen extends StatefulWidget {
  @override
  _ImageSelectionScreenState createState() => _ImageSelectionScreenState();
}

class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
  List<String> imagePaths = [
    'assets/images/dog1.jpg',
    'assets/images/dog2.jpg',
    'assets/images/dog3.jpg',
    'assets/images/dog4.jpg',
  ];

  List<bool> selectedImages = List.generate(4, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Selection'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 한 줄에 4장의 이미지가 들어가도록 수정
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImages[index] = !selectedImages[index];
                    });
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        imagePaths[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      selectedImages[index]
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 30.0,
                            )
                          : Container(),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              printSelectedImages();
            },
            child: Text('다음'),
          ),
        ],
      ),
    );
  }

  void printSelectedImages() {
    List<String> selectedPaths = [];
    for (int i = 0; i < selectedImages.length; i++) {
      if (selectedImages[i]) {
        selectedPaths.add(imagePaths[i]);
      }
    }
    print('Selected Images: $selectedPaths');
  }
}
