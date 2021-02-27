import 'package:final_submission/model/article_response.dart';
import 'package:final_submission/service/repositories.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SourcesnewsBloc {
  final NewsRepo _newsRepo = NewsRepo();
  final BehaviorSubject<ArticleResponse> _subject =
      BehaviorSubject<ArticleResponse>();

  getSourceNews(String sourceId) async {
    ArticleResponse response = await _newsRepo.getSourceNews(sourceId);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }
  BehaviorSubject<ArticleResponse> get subject => _subject;
}
final sourceNewsBloc = SourcesnewsBloc();
