import 'package:flutter/material.dart';
import 'package:weather_flutter_app/routes/onboarding.dart';
import 'package:weather_flutter_app/routes/about.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                title: Text('Theme', semanticsLabel: 'Choose theme'),
                subtitle: Text('Light', semanticsLabel: 'Light'),
                activeColor: Colors.green,
                value: true,
                onChanged: (value) => print('theme changed'),
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
            ],
          ),
        ),
      ),
    );
  }
}
