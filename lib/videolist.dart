import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_api/youtube_api.dart';
import 'playview.dart';

class listview extends StatefulWidget {
  @override
  _listview createState() => _listview();
}

class _listview extends State<listview> {
  static int maxResult = 10;
  static String key = "AIzaSyCoHKFaTeaTgeZvbSI9UexIVlWZcH-HYhc";
  final FocusNode textfield = FocusNode();
  YoutubeAPI ytApi = YoutubeAPI(key, type: "video", maxResults: maxResult);
  List<YT_API> ytResult = [];
  bool isclick = false;
  bool isLoading = false;
  final searchController = TextEditingController();
  String regionCode = 'KR';

  String query = "Java";

  callAPI() async {
    setState(() {
      isLoading = true;
    });

    ytResult = await ytApi.getTrends(regionCode: regionCode);
    isLoading = true;
    ytResult = await ytApi.search(query);
    //ytResult = await ytApi.nextPage();
    setState(() {
      isLoading = false;
    });
  }

  void loadYoutube() async {
    setState(() {
      isLoading = true;
    });
    ytResult = await ytApi.nextPage();
    setState(() {
      isLoading = false;
    });
  }

  void searchYoutube(String searh) async {
    query = searh;
    print(searh);
    setState(() {
      isLoading = true;
    });
    ytResult = await ytApi.search(query);
    //ytResult = await ytApi.nextPage();
    setState(() {
      isLoading = false;
    });
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
          automaticallyImplyLeading: false,
          title: Text("Youtube"),
          backgroundColor: Colors.red,
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.search),
                onPressed: () async {
                  searchYoutube(searchController.text);
                }),
            Container(
                padding: const EdgeInsets.all(8.0),
                width: 150, // do it in both Container
                child: TextFormField(
                  focusNode: textfield,
                  onFieldSubmitted: (value) {
                    textfield.unfocus();
                    searchYoutube(searchController.text);
                    searchController.text = '';
                  },
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {});
                  },
                  controller: searchController,
                )),
          ],
        ),
        body: !isLoading
            ? Container(
                child: _buildList(context)
              )
            : Center(
                child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
              )));
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {

          // 홀수 행은 구분자를 넣어준다.
          final index = i ~/ 2; // i를 2로 나누었을때, 결과의 정수부분을 반환한다.
          print(index);
          if (index >= ytResult.length) {
            print("!!");
            // 가지고 있는 문자열을 모두 소진하면, 10개를 더 불러온다.
            loadYoutube();
          }
          return listItem(index);
        });
  }



  Widget listItem(index) {
    return Card(
        child: new InkWell(
      onTap: () {
        print("!111" + ytResult[index].id);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => YoutubeAppDemo(url: ytResult[index].id)),
        );
      },
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
    ));
  }
}
