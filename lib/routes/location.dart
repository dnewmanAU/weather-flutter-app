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
                return Expanded(
                  child: ListView(
                    children: [
                      Visibility(
                        visible:
                            snapshot.connectionState == ConnectionState.done &&
                                snapshot.data?[0].length > 0,
                        child: Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 25.0),
                              child: Center(
                                  child: Text(
                                'Favourites',
                                style: TextStyle(fontSize: 20),
                              )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: Divider(
                                color: Colors.blue,
                                thickness: 1.3,
                                height: 5,
                                indent: 12,
                                endIndent: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (var location in snapshot.data?[0] ?? <String>[])
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 15.0),
                          child: Card(
                            child: ListTile(
                              leading: IconButton(
                                  icon: const Icon(Icons.star_rounded),
                                  // remove a favourite and add to recent
                                  onPressed: () {
                                    setState(() {
                                      _removeLocation('favourites', location);
                                      _addLocation('recent', location);
                                    });
                                  }),
                              title: InkWell(
                                child: Text(location),
                                onTap: () {
                                  _setLocation(location);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()));
                                },
                              ),
                            ),
                          ),
                        ),
                      Visibility(
                        visible:
                            snapshot.connectionState == ConnectionState.done &&
                                snapshot.data?[1].length > 0,
                        child: Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 25.0),
                              child: Center(
                                  child: Text(
                                'Recent',
                                style: TextStyle(fontSize: 20),
                              )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: Divider(
                                color: Colors.blue,
                                thickness: 1.3,
                                height: 5,
                                indent: 12,
                                endIndent: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (var location in snapshot.data?[1] ?? <String>[])
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 15.0),
                          child: Card(
                            child: ListTile(
                              leading: IconButton(
                                icon: const Icon(Icons.star_outline_rounded),
                                // add a favourite and remove from recent
                                onPressed: () {
                                  setState(() {
                                    _addLocation('favourites', location);
                                    _removeLocation('recent', location);
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
                                          builder: (context) => const Home()));
                                },
                              ),
                              trailing: IconButton(
                                  icon: const Icon(Icons.close_rounded),
                                  // remove from recent
                                  onPressed: () {
                                    setState(() =>
                                        _removeLocation('recent', location));
                                  }),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
