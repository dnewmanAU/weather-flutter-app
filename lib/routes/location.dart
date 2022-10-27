import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/preferences.dart';
import '../widgets/location/search_location.dart';
import '../../routes/home.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  bool _favouritesExpanded = true;
  bool _recentExpanded = true;

  @override
  Widget build(BuildContext context) {
    // TODO interleave drop downs
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SearchLocation(),
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
                                    in context.read<Preferences>().favourites)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 15.0),
                                    child: Card(
                                      child: ListTile(
                                        leading: IconButton(
                                            icon:
                                                const Icon(Icons.star_rounded),
                                            onPressed: () {
                                              setState(() {
                                                // remove from favourites
                                                context
                                                    .read<Preferences>()
                                                    .removeFavourite = location;
                                                // add to recent
                                                context
                                                    .read<Preferences>()
                                                    .addRecent = location;
                                              });
                                            }),
                                        title: InkWell(
                                          child: Text(location),
                                          onTap: () {
                                            // add to location
                                            context
                                                .read<Preferences>()
                                                .location = location;
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
                                    in context.read<Preferences>().recent)
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
                                              // add to favourites
                                              context
                                                  .read<Preferences>()
                                                  .addFavourite = location;
                                              // remove from recent
                                              context
                                                  .read<Preferences>()
                                                  .removeRecent = location;
                                            });
                                          },
                                        ),
                                        title: InkWell(
                                          child: Text(location),
                                          onTap: () {
                                            // add to location
                                            context
                                                .read<Preferences>()
                                                .location = location;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Home()));
                                          },
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.close_rounded),
                                          // remove from recent
                                          onPressed: () {
                                            setState(() {
                                              // add to location
                                              context
                                                  .read<Preferences>()
                                                  .removeRecent = location;
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
