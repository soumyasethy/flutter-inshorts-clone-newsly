import 'package:flutter/material.dart';
import 'Utils.dart';

class NewsCard extends StatelessWidget {
  final String url,
      imgUrl,
      primaryText,
      secondaryText,
      sourceName,
      author,
      publishedAt;

  NewsCard(
      {this.url,
      this.imgUrl,
      this.primaryText,
      this.secondaryText,
      this.sourceName,
      this.author,
      this.publishedAt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.2),
            child: Image.network(
              imgUrl,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              primaryText,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                secondaryText,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
              )),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
            child: Text(
              "swipe left for more at $sourceName by $author / ${Utils.timeAgoSinceDate(publishedAt)}",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12.0,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.fromLTRB(16.0, 16 * 2.0, 16.0, 4.0),
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Utils.launchURL(context, url);
          },
          child: Container(
            width: double.infinity,
            height: 50,
            child: Center(
                child: Text(
              "Tap to read full story at ${sourceName}",
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
