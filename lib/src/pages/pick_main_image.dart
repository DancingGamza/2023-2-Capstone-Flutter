import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sns_form/src/pages/login.dart';
class ImageAlbumPage extends StatelessWidget {
  final List<Map<String, dynamic>> images;

  const ImageAlbumPage({Key? key, required this.images}) : super(key: key);

  Future<void> _handleImageSelection(BuildContext context, int selectedImageId) async {
    try {


      Dio dio = Dio();
      Response response = await dio.get(
        'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com/animal/image/$selectedImageId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Display a success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Image selected successfully!'),
        ));

        // Navigate back to the previous page
        Navigator.pop(context);
      } else {
        // Handle the error
        print('Failed to select image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle the exception
      print('Error selecting image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Album'),
         backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Handle image tap, for example, send the image ID to the server
              _handleImageSelection(context, images[index]['id']);
            },
            child: Image.network(
              'http://ec2-13-209-17-240.ap-northeast-2.compute.amazonaws.com${images[index]['image']}',
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}