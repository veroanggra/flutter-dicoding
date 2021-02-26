import 'dart:html';

import 'package:final_submission/model/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:final_submission/theme/common/setup.dart' as Style;

class DetailScreen extends StatefulWidget {
  final ArticleModel article;

  DetailScreen({Key key, @required this.article}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState(article);
}

class _DetailScreenState extends State<DetailScreen> {
  final ArticleModel articleModel;

  _DetailScreenState(this.articleModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          launch(articleModel.url);
        },
        child: Container(
          height: 48.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white, gradient: Style.Colors.primaryGradient),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Read More',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SFPro-Bold',
                    fontSize: 15.0),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Style.Colors.mainColor,
        title: Text(
          articleModel.title,
          style: TextStyle(
              fontSize: Theme.of(context).platform == TargetPlatform.android
                  ? 17.0
                  : 17.0,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: FadeInImage.assetNetwork(
              alignment: Alignment.topCenter,
              placeholder: 'assets/img/placeholder.png',
              image: articleModel.img == null
                  ? 'http://to-let.com.bd/operator/images/noimage.png'
                  : articleModel.img,
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 1 / 3,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      articleModel.date.substring(0, 10),
                      style: TextStyle(
                          color: Style.Colors.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    articleModel.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  timeUntil(DateTime.parse(articleModel.date)),
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Html(
                  data: articleModel.content,
                  renderNewlines: true,
                  defaultTextStyle:
                      TextStyle(fontSize: 14.0, color: Colors.black),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String timeUntil(DateTime parse) {}
}
