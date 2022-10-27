import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/preferences.dart';
import '../routes/onboard.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
              SwitchListTile(
                title: const Text('Theme', semanticsLabel: 'Choose theme'),
                subtitle: Text(context.watch<Preferences>().themeType),
                activeColor: Colors.green,
                value: context.watch<Preferences>().themeType == 'Light'
                    ? false
                    : true,
                onChanged: (value) {
                  if (value == false) {
                    context.read<Preferences>().themeType = 'Light';
                  } else {
                    context.read<Preferences>().themeType = 'Dark';
                  }
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
                  MaterialPageRoute(builder: (context) => const Onboard()),
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
                title: const Text('Licenses'),
                subtitle: const Text('View app licenses'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LicensePage(
                            applicationName: 'Flutter Weather App',
                            applicationVersion: 'Version: 1.0',
                            applicationLegalese:
                                'Developed by David Newman\n{repo link here}',
                          )),
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
