import 'package:flutter/cupertino.dart';

import 'main.dart';
import 'videolist.dart';
import 'playview.dart';

final route={
  '/':(BuildContext context) => FirstRoute(),
  '/list':(BuildContext context) => YoutubeApp(),
  '/view':(BuildContext context) => videolist(),

};