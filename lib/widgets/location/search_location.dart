import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/preferences.dart';
import '../../routes/home.dart';

class SearchLocation extends StatefulWidget {
  final SharedPreferences prefs;

  const SearchLocation({Key? key, required this.prefs}) : super(key: key);

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 2.0, 25.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter a town or city',
                ),
                controller: _textController,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // add to location
              context.read<Preferences>().location = _textController.text;
              // avoid duplicates across both favourites and recent
              if (!context
                  .read<Preferences>()
                  .favourites
                  .contains(_textController.text)) {
                // add to recent
                context.read<Preferences>().addRecent = _textController.text;
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home(prefs: widget.prefs)));
            },
          ),
        ],
      ),
    );
  }
}
