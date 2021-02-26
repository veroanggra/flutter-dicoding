import 'package:final_submission/model/article_response.dart';
import 'package:final_submission/service/repositories.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final NewsRepo _newsRepo = NewsRepo();
  final BehaviorSubject<ArticleResponse> _subject =
      BehaviorSubject<ArticleResponse>();

  search(String value) async {
    ArticleResponse response = await _newsRepo.search(value);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;
}

final searchBloc = SearchBloc();
