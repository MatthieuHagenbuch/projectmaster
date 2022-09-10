import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectmaster/widgets/appBar.dart';
import 'package:settings_ui/settings_ui.dart';
/*
 Author : Matthieu
 Display settings
*/

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Settings'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                value: const Text('English'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {
                  //Abandon après 2h de recherches
                },
                initialValue: true,
                leading: const Icon(Icons.format_paint),
                title: const Text('Enable custom theme'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
