import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_submission/bloc/headlines_bloc.dart';
import 'package:final_submission/model/article.dart';
import 'package:final_submission/model/article_response.dart';
import 'package:final_submission/theme/common/custom_widget.dart';
import 'package:final_submission/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeaderSliding extends StatefulWidget {
  @override
  _HeaderSlidingState createState() => _HeaderSlidingState();
}

class _HeaderSlidingState extends State<HeaderSliding> {
  @override
  void initState() {
    super.initState();
    getTopHeadlineBloc..getHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponse>(
      stream: getTopHeadlineBloc.subject.stream,
      builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return errorHandleWidget(snapshot.data.error);
          }
          return _headlineWidgetSlider(snapshot.data);
        } else if (snapshot.hasError) {
          return errorHandleWidget(snapshot.error);
        } else {
          return loadingWidget();
        }
      },
    );
  }

  Widget _headlineWidgetSlider(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
            enlargeCenterPage: false, height: 200.0, viewportFraction: 0.9),
        items: getExpenseSliders(articles),
      ),
    );
  }

  getExpenseSliders(List<ArticleModel> articles) {
    return articles
        .map(
          (article) => GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(article: article)));
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: article.img == null
                                ? AssetImage('assets/img/placeholder.jpg')
                                : NetworkImage(article.img))),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0.1, 0.9],
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.white.withOpacity(0.0)
                          ],
                        )),
                  ),
                  Positioned(
                    bottom: 30.0,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      width: 250.0,
                      child: Column(
                        children: <Widget>[
                          Text(
                            article.title,
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    left: 10.0,
                    child: Text(
                      article.source.name,
                      style: TextStyle(color: Colors.white54, fontSize: 9.0),
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    right: 10.0,
                    child: Text(
                      timeUntil(DateTime.parse(article.date)),
                      style: TextStyle(color: Colors.white54, fontSize: 9.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  String timeUntil(DateTime parse) {
    return timeago.format(parse, allowFromNow: true, locale: 'en');
  }
}
