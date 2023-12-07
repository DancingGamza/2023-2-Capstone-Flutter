import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // MaterialApp 추가
      home: Scaffold(
        appBar: AppBar(
          title: Text('InkWell로 표시하기'),
        ),
        body: Center(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('InkWell을 눌렀습니다!'),
                    content: Text('여기에 원하는 내용을 표시할 수 있습니다.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('확인'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('InkWell을 눌러보세요'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
