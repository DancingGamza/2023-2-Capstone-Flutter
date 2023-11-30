import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PetDetailsPage(
        imageUrl: 'https://image.dongascience.com/Photo/2020/03/5bddba7b6574b95d37b6079c199d7101.jpg',
        petName: 'Max',
        petFeatures: 'Friendly, Playful',
      ),
    );
  }
}

class PetDetailsPage extends StatefulWidget {
  final String imageUrl;
  final String petName;
  final String petFeatures;

  PetDetailsPage({
    required this.imageUrl,
    required this.petName,
    required this.petFeatures,
  });

  @override
  _PetDetailsPageState createState() => _PetDetailsPageState();
}

//...

class _PetDetailsPageState extends State<PetDetailsPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _featuresController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.petName;
    _featuresController.text = widget.petFeatures;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: 100,
                maxHeight: 200,
              ),
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Pet Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _featuresController,
              decoration: InputDecoration(labelText: 'Pet Features'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle image registration logic
              },
              child: Text('이미지 등록'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Handle setting the image as the representative image logic
              },
              child: Text('대표이미지 설정'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Handle update logic
                String updatedName = _nameController.text;
                String updatedFeatures = _featuresController.text;
                // Update the pet details as needed
              },
              child: Text('수정'),
            ),
          ],
        ),
      ),
    );
  }
}

