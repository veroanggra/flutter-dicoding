import 'package:final_submission/theme/widget/header.dart';
import 'package:final_submission/theme/widget/hot_news.dart';
import 'package:final_submission/theme/widget/top_channel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        HeaderSliding(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Text(
                'Top Channels',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              )
            ],
          ),
        ),
        TopChannelWidget(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Text(
                'Hot News',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              )
            ],
          ),
        ),
        HotNewsWidget()
      ],
    );
  }
}
