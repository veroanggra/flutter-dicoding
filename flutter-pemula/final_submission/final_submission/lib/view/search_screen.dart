import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:final_submission/bloc/search_bloc.dart';
import 'package:flutter/material.dart';

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
                hintStyle: TextStyle(fontSize: 14.0, color: Style)),
          ),
        )
      ],
    );
  }
}
