import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/onboarding.dart';
import '../routes/about.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _getDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('darkMode') ?? false;
  }

  _setDarkMode(bool darkMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', darkMode);
  }

  void _clearAppData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings', semanticsLabel: 'Settings screen'),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder(
                future: _getDarkMode(),
                builder: (context, snapshot) {
                  return SwitchListTile(
                    title: const Text('Theme', semanticsLabel: 'Choose theme'),
                    subtitle: Text(snapshot.data ?? false ? 'Dark' : 'Light'),
                    activeColor: Colors.green,
                    value: snapshot.data ?? false,
                    onChanged: (value) {
                      setState(() {
                        _setDarkMode(value);
                      });
                    },
                  );
                },
              ),
              const Divider(
                color: Colors.black,
                thickness: 0.2,
                height: 4,
                indent: 8,
                endIndent: 8,
              ),
              ListTile(
                title: const Text('Tour'),
                subtitle: const Text('Review the guided tour'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Onboarding()),
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 0.2,
                height: 4,
                indent: 8,
                endIndent: 8,
              ),
              ListTile(
                title: const Text('About'),
                subtitle: const Text('View information about the app'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const About()),
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 0.2,
                height: 4,
                indent: 8,
                endIndent: 8,
              ),
              ListTile(
                title: const Text('Reset'),
                subtitle: const Text('Clear favourite locations'),
                trailing: const Icon(Icons.warning_amber),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text('Cannot be undone'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('No'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text('Yes',
                            style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          _clearAppData();
                          Navigator.pop(context);
                          const confirmationDialog = SnackBar(
                            content: Text('Favourites deleted'),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(confirmationDialog);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
