import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_flutter_app/routes/home.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final _textController = TextEditingController();

  bool _favouritesExpanded = false;
  bool _recentExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  void _setLocation(location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('location', location);
  }

  // two types: 'favourites' and 'recent'
  Future<List<String>> _getLocations(String type) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(type) ?? <String>[];
  }

  // two types: 'favourites' and 'recent'
  void _addLocation(String type, String location) async {
    final prefs = await SharedPreferences.getInstance();
    var locations = prefs.getStringList(type) ?? <String>[];
    // unique locations only and ignore empty locations
    if (!locations.contains(location) && location != '') {
      locations.add(location);
    }
    await prefs.setStringList(type, locations);
  }

  // two types: 'favourites' and 'recent'
  void _removeLocation(String type, String location) async {
    final prefs = await SharedPreferences.getInstance();
    var locations = prefs.getStringList(type) ?? <String>[];
    locations.remove(location);
    await prefs.setStringList(type, locations);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Form(
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
                      _setLocation(_textController.text);
                      _addLocation('recent', _textController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    },
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: Future.wait(
                  [_getLocations('favourites'), _getLocations('recent')]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 30),
                      child: ExpansionPanelList(
                        expansionCallback: (int index, bool favouriteExpanded) {
                          setState(() {
                            _favouritesExpanded = !favouriteExpanded;
                          });
                        },
                        children: [
                          //for (var location in snapshot.data?[1] ?? <String>[])
                          ExpansionPanel(
                            headerBuilder: (context, isExpanded) {
                              return const Center(
                                  child: Text(
                                'Favourites',
                                style: TextStyle(fontSize: 20),
                              ));
                            },
                            body: Padding(
                              padding: const EdgeInsets.only(bottom: 35),
                              child: Column(
                                children: [
                                  for (var location
                                      in snapshot.data?[0] ?? <String>[])
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 15.0),
                                      child: Card(
                                        child: ListTile(
                                          leading: IconButton(
                                              icon: const Icon(
                                                  Icons.star_rounded),
                                              // remove a favourite and add to recent
                                              onPressed: () {
                                                setState(() {
                                                  _removeLocation(
                                                      'favourites', location);
                                                  _addLocation(
                                                      'recent', location);
                                                });
                                              }),
                                          title: InkWell(
                                            child: Text(location),
                                            onTap: () {
                                              _setLocation(location);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Home()));
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            isExpanded: _favouritesExpanded,
                            backgroundColor: Colors.grey,
                            canTapOnHeader: true,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 30),
                      child: ExpansionPanelList(
                        expansionCallback: (_, bool recentExpanded) {
                          setState(() {
                            _recentExpanded = !recentExpanded;
                          });
                        },
                        children: [
                          //for (var location in snapshot.data?[1] ?? <String>[])
                          ExpansionPanel(
                            headerBuilder: (context, isExpanded) {
                              return const Center(
                                  child: Text(
                                'Recent',
                                style: TextStyle(fontSize: 20),
                              ));
                            },
                            body: Padding(
                              padding: const EdgeInsets.only(bottom: 35),
                              child: Column(
                                children: [
                                  for (var location
                                      in snapshot.data?[1] ?? <String>[])
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 15.0),
                                      child: Card(
                                        child: ListTile(
                                          leading: IconButton(
                                            icon: const Icon(
                                                Icons.star_outline_rounded),
                                            // add a favourite and remove from recent
                                            onPressed: () {
                                              setState(() {
                                                _addLocation(
                                                    'favourites', location);
                                                _removeLocation(
                                                    'recent', location);
                                              });
                                            },
                                          ),
                                          title: InkWell(
                                            child: Text(location),
                                            onTap: () {
                                              _setLocation(location);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Home()));
                                            },
                                          ),
                                          trailing: IconButton(
                                            icon:
                                                const Icon(Icons.close_rounded),
                                            onPressed: () {
                                              setState(() {
                                                _removeLocation(
                                                    'recent', location);
                                              });
                                            },
                                            // remove from recent
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            isExpanded: _recentExpanded,
                            backgroundColor: Colors.grey,
                            canTapOnHeader: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
