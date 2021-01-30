import 'package:flutter/material.dart';
import 'package:flutter_youtube/main.dart';
import 'package:flutter_youtube/playview.dart';
import 'package:flutter_youtube/videolist.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named routes Demo',
    // "/"을 앱이 시작하게 될 route로 지정합니다. 본 예제에서는 FirstScreen 위젯이 첫 번째 페이지가
    // 될 것입니다.
    initialRoute: '/',
    routes: {
      // When we navigate to the "/" route, build the FirstScreen Widget
      // "/" Route로 이동하면, FirstScreen 위젯을 생성합니다.
      '/': (context) => FirstRoute(),
      // "/second" route로 이동하면, SecondScreen 위젯을 생성합니다.
      '/list': (context) => listview(),
      '/play' : (context) => YoutubeAppDemo(),
    },
  ));
}
