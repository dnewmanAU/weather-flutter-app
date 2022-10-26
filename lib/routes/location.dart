import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/locations_provider.dart';
import '../providers/favourites_provider.dart';
import '../providers/recent_provider.dart';
import '../routes/home.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final _textController = TextEditingController();
  late SharedPreferences prefs;

  bool _favouritesExpanded = false;
  bool _recentExpanded = false;

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  void getPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  List<String> _iterableLocations(type) {
    if (type == 'favourites') {
      var locations = Provider.of<Favourites>(context, listen: false).getFavourites;
      return locations;
    } else {
      var locations = Provider.of<Recent>(context, listen: false).getRecent;
      return locations;
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO interleave drop downs
    return SafeArea(
      child: Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => Locations(prefs)),
            ChangeNotifierProvider(create: (context) => Favourites(prefs)),
            ChangeNotifierProvider(create: (context) => Recent(prefs)),
          ],
          child: Column(
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
                        Provider.of<Locations>(context, listen: false).setLocation(_textController.text);
                        Provider.of<Recent>(context, listen: false).addRecent(_textController.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      },
                    ),
                  ],
                ),
              ),
              Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 5, 30, 30),
                        child: ExpansionPanelList(
                          expansionCallback: (_, bool favouritesExpanded) {
                            setState(() {
                              _favouritesExpanded = !favouritesExpanded;
                            });
                          },
                          children: [
                            ExpansionPanel(
                              headerBuilder: (context, isExpanded) {
                                return const Center(
                                    child: Text(
                                  'Favourites',
                                  style: TextStyle(fontSize: 20),
                                ));
                              },
                              body: Padding(
                                padding: const EdgeInsets.only(bottom: 32),
                                child: Column(
                                  children: [
                                    for (var location
                                        in _iterableLocations('favourites'))
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
                                                    Provider.of<Favourites>(context, listen: false).removeFavourite(location);
                                                    Provider.of<Recent>(context, listen: false).addRecent(location);
                                                  });
                                                }),
                                            title: InkWell(
                                              child: Text(location),
                                              onTap: () {
                                                Provider.of<Locations>(context, listen: false).setLocation(location);
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
                            ExpansionPanel(
                              headerBuilder: (context, isExpanded) {
                                return const Center(
                                    child: Text(
                                  'Recent',
                                  style: TextStyle(fontSize: 20),
                                ));
                              },
                              body: Padding(
                                padding: const EdgeInsets.only(bottom: 32),
                                child: Column(
                                  children: [
                                    for (var location
                                        in _iterableLocations('recent'))
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
                                                  Provider.of<Favourites>(context, listen: false).addFavourite(location);
                                                  Provider.of<Recent>(context, listen: false).removeRecent(location);
                                                });
                                              },
                                            ),
                                            title: InkWell(
                                              child: Text(location),
                                              onTap: () {
                                                Provider.of<Locations>(context, listen: false).setLocation(location);
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
                                              // remove from recent
                                              onPressed: () {
                                                setState(() {
                                                  Provider.of<Recent>(context, listen: false).removeRecent(location);
                                                });
                                              },
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
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
