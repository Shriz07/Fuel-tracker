import 'package:flutter/material.dart';
import 'package:fuel_tracker/Screens/Drawer/drawer.dart';
import 'package:fuel_tracker/Widgets/app_bar.dart';
import 'package:fuel_tracker/l10n/app_localizations.dart';
import 'package:fuel_tracker/services/authentication_services/auth_services.dart';
import 'package:fuel_tracker/services/dark_mode/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:rolling_switch/rolling_switch.dart';

class Settings extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    var t = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MyAppBar(context, t!.settingsNavbarTitle),
      drawer: MyDrawer(loginProvider),
      body: Container(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Text(
                t.settingsDarkMode,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              RollingSwitch.icon(
                height: MediaQuery.of(context).size.height * 0.07 > 50.0 ? MediaQuery.of(context).size.height * 0.07 : 50.0,
                initialState: themeChange.darkTheme,
                onChanged: (bool state) {
                  themeChange.darkTheme = !themeChange.darkTheme;
                },
                rollingInfoRight: const RollingIconInfo(
                  icon: Icons.check,
                  text: Text('ON'),
                ),
                rollingInfoLeft: const RollingIconInfo(
                  icon: Icons.clear,
                  backgroundColor: Colors.grey,
                  text: Text('OFF'),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
