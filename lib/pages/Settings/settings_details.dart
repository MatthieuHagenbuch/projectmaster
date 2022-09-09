import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Settings'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Language'),
                value: Text('English'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {
                  //Abandon après 2h de recherches
                },
                initialValue: true,
                leading: Icon(Icons.format_paint),
                title: Text('Enable custom theme'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
