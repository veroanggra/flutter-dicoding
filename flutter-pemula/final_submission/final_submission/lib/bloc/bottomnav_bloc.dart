import 'dart:async';

import 'package:final_submission/utils/common.dart';

class BottomNavBloc {
  final StreamController<NavBarItem> _navBarItem =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.HOME;

  Stream<NavBarItem> get itemStream => _navBarItem.stream;

  void chooseItem(int index) {
    switch (index) {
      case 0:
        _navBarItem.sink.add(NavBarItem.HOME);
        break;
      case 1:
        _navBarItem.sink.add(NavBarItem.PORTAL);
        break;
      case 2:
        _navBarItem.sink.add(NavBarItem.SEARCH);
        break;
    }
  }

  close() {
    _navBarItem?.close();
  }
}
