import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoApp(),
    );
  }
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  static String key = "AIzaSyCoHKFaTeaTgeZvbSI9UexIVlWZcH-HYhc";

  YoutubeAPI ytApi = YoutubeAPI(key, type: "playlist");
  List<YT_API> ytResult = [];
  bool isclick = false;
  final searchController = TextEditingController();

  callAPI() async {
    String query = "Java";
    ytResult = await ytApi.search(query);
    ytResult = await ytApi.nextPage();
    setState(() {});
  }

  void searchYoutube(String query) async {
    print(query);
    ytResult = await ytApi.search(query);
    ytResult = await ytApi.nextPage();
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    callAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Youtube"),
        backgroundColor: Colors.red,
        actions: <Widget>[
          new IconButton(icon: new Icon( Icons.search), onPressed: ()async { searchYoutube(searchController.text);}),
          Container(
              padding: const EdgeInsets.all(8.0),
              width: 150, // do it in both Container
            child: TextField( onChanged: (text) { setState(() {  }); },
            controller: searchController,)
          ),


        ],

      ),
      body: Container(
        child: ListView.builder(
          itemCount: ytResult.length,
          itemBuilder: (_, int index) => listItem(index),
        ),
      ),
    );
  }
  void search(){

}
  Widget listItem(index) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Image.network(
              ytResult[index].thumbnail['default']['url'],
            ),
            Padding(padding: EdgeInsets.only(right: 20.0)),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        ytResult[index].title,
                        softWrap: true,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 1.5)),
                      Text(
                        ytResult[index].channelTitle,
                        softWrap: true,
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}