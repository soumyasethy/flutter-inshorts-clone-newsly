import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'NewsCards.dart';
import 'NewsDummy.dart';
import 'NewsModal.dart';
import 'shared_pref.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  NewsModal newsModal;

  @override
  void initState() {
    newsModal = NewsModal.fromJson(newsDummy);
    setupLastIndex();
    super.initState();
  }

  void updateIndex(newIndex) {
    setState(() {
      index = newIndex;
    });
    SharePreference.setLastIndex(newIndex);
  }

  void setupLastIndex() async {
    int lastIndex = await SharePreference.getLastIndex();
    if (lastIndex != null && lastIndex < newsModal.result.length - 1) {
      updateIndex(lastIndex);
    }
  }

  void updateContent(direction) {
    if (index <= 0 && direction == DismissDirection.down) {
      index = newsModal.result.length - 1;
    } else if (index == newsModal.result.length - 1 &&
        direction == DismissDirection.up) {
      index = 0;
    } else if (direction == DismissDirection.up) {
      index++;
    } else {
      index--;
    }
    updateIndex(index);
  }

  String getShareText() {
    return "${newsModal.result[index].title}\n${newsModal.result[index].url}";
  }

  Widget newsCard(int index) {
    return NewsCard(
      imgUrl: newsModal.result[index].urlToImage,
      primaryText: newsModal.result[index].title,
      secondaryText: newsModal.result[index].description,
      sourceName: newsModal.result[index].sourceName,
      author: newsModal.result[index].author,
      publishedAt: newsModal.result[index].publishedAt,
      url: newsModal.result[index].url,
    );
  }

  @override
  Widget build(BuildContext context) {
    int prevIndex = index <= 0 ? 0 : index - 1;
    int nextIndex = index == newsModal.result.length - 1 ? 0 : index + 1;
    return Scaffold(
      appBar: new AppBar(
        title: new Text('News.ly'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
//            onPressed: _refresh,
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {
              Share.share(getShareText());
            },
          )
        ],
      ),
      body: Center(
        child: Dismissible(
          background: newsCard(prevIndex),
          child: newsCard(index),
          secondaryBackground: newsCard(nextIndex),
          resizeDuration: Duration(milliseconds: 10),
          key: Key(index.toString()),
          direction: DismissDirection.vertical,
          onDismissed: (direction) {
            updateContent(direction);
          },
        ),
      ),
    );
  }
}
