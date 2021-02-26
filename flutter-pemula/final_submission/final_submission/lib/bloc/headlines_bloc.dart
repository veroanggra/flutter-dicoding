import 'package:final_submission/model/article_response.dart';
import 'package:final_submission/service/repositories.dart';
import 'package:rxdart/rxdart.dart';

class GetHeadlinesBloc {
  final NewsRepo _newsRepo = NewsRepo();
  final BehaviorSubject<ArticleResponse> _subject =
      BehaviorSubject<ArticleResponse>();

  getHeadlines() async {
    ArticleResponse response = await _newsRepo.getTopHeadlines();
    _subject.sink.add(response);
  }
  dispose(){
    _subject.close();
  }
  BehaviorSubject<ArticleResponse> get subject => _subject;
}
final getTopHeadlineBloc = GetHeadlinesBloc();
