import 'package:final_submission/model/source_response.dart';
import 'package:final_submission/service/repositories.dart';
import 'package:rxdart/rxdart.dart';

class SourceBloc {
  final NewsRepo _newsRepo = NewsRepo();
  final BehaviorSubject<SourceResponse> _subject =
      BehaviorSubject<SourceResponse>();

  getSources() async {
    SourceResponse response = await _newsRepo.getSources();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<SourceResponse> get subject => _subject;
}

final getsourcesBloc = SourceBloc();
