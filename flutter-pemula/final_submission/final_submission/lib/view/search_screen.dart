import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:final_submission/bloc/search_bloc.dart';
import 'package:final_submission/model/article.dart';
import 'package:final_submission/model/article_response.dart';
import 'package:final_submission/theme/common/custom_widget.dart';
import 'package:final_submission/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_submission/theme/common/setup.dart' as Style;
import 'package:timeago/timeago.dart' as timeago;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchBloc..search('');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: TextFormField(
            style: TextStyle(fontSize: 14.0, color: Colors.black),
            controller: _searchController,
            onChanged: (changed) {
              searchBloc..search(_searchController.text);
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.grey[100],
              suffixIcon: _searchController.text.length > 0
                  ? IconButton(
                      icon: Icon(
                        EvaIcons.backspaceOutline,
                        color: Colors.grey[500],
                        size: 16.0,
                      ),
                      onPressed: () {
                        setState(() {
                          Focus.of(context).requestFocus(FocusNode());
                          _searchController.clear();
                          searchBloc.search(_searchController.text);
                        });
                      },
                    )
                  : Icon(
                      EvaIcons.searchOutline,
                      color: Colors.grey[500],
                      size: 16.0,
                    ),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey[100].withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(30.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey[100].withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(30.0)),
              contentPadding: EdgeInsets.only(left: 15.0, right: 15.0),
              labelText: 'Search...',
              hintStyle: TextStyle(
                  fontSize: 14.0,
                  color: Style.Colors.grey,
                  fontWeight: FontWeight.w500),
              labelStyle: TextStyle(
                  fontSize: 14.0,
                  color: Style.Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            autocorrect: false,
            autovalidate: true,
          ),
        ),
        Expanded(
          child: StreamBuilder<ArticleResponse>(
            stream: searchBloc.subject.stream,
            builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return Container();
                }
                return _sourceNewsWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return Container();
              } else {
                return loadingWidget();
              }
            },
          ),
        )
      ],
    );
  }

  Widget _sourceNewsWidget(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;
    if (articles.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'No More',
              style: TextStyle(color: Colors.black45),
            )
          ],
        ),
      );
    } else
      return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    article: articles[index],
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[200], width: 1.0),
                ),
                color: Colors.white,
              ),
              height: 150.0,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width * 3 / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          articles[index].title,
                          maxLines: 3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 14.0),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      timeUntil(
                                          DateTime.parse(articles[index].date)),
                                      style: TextStyle(
                                          color: Colors.black26,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.0),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10.0),
                    width: MediaQuery.of(context).size.width * 2 / 5,
                    height: 130.0,
                    child: FadeInImage.assetNetwork(
                      alignment: Alignment.topCenter,
                      placeholder: 'assets/img/placeholder.jpg',
                      image: articles[index].img == null
                          ? "http://to-let.com.bd/operator/images/noimage.png"
                          : articles[index].img,
                      fit: BoxFit.fitHeight,
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height * 1 / 3,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
  }

  String timeUntil(DateTime parse) {
    return timeago.format(parse, allowFromNow: true, locale: 'en');
  }
}
