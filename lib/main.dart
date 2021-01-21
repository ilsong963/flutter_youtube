import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_youtube/playview.dart';

import 'videolist.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the FirstScreen Widget
        // "/" Route로 이동하면, FirstScreen 위젯을 생성합니다.
        '/': (context) => FirstRoute(),
        // "/second" route로 이동하면, SecondScreen 위젯을 생성합니다.
        '/list': (context) => YoutubeApp(),
        '/view': (context) => videolist(),
      },
  )
  );
}

class FirstRoute extends StatefulWidget {
  @override
  _FirstRoute createState() => _FirstRoute();
}

class _FirstRoute extends State<FirstRoute> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/list');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.red,
          body: Container(
              alignment: Alignment.bottomCenter,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Youtube",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                    CircularProgressIndicator(
                      backgroundColor: Colors.red,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
              ))), //<- place where the image appears
    );
  }
}
