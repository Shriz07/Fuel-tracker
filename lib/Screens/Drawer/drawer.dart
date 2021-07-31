import 'package:flutter/material.dart';
import 'package:fuel_tracker/Screens/About/about.dart';
import 'package:fuel_tracker/Screens/Car_Notifications/carNotifications.dart';
import 'package:fuel_tracker/Screens/Petrol_charts/charts.dart';
import 'package:fuel_tracker/l10n/app_localizations.dart';
import 'package:fuel_tracker/services/authentication_services/auth_services.dart';
import 'package:fuel_tracker/services/dark_mode/darkThemeProvider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer(this.loginProvider);
  final AuthServices loginProvider;

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    return Drawer(
      child: Container(
        color: Theme.of(context).splashColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 90,
              child: DrawerHeader(
                decoration: BoxDecoration(gradient: LinearGradient(colors: <Color>[Theme.of(context).secondaryHeaderColor, Theme.of(context).primaryColor])),
                child: Text(
                  t!.drawerTitle,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
            CustomListTile(Icons.notifications, t.drawerNotifications, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CarNotifications()));
            }),
            CustomListTile(Icons.bar_chart, t.drawerCharts, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Charts()));
            }),
            CustomListTile(Icons.settings, t.drawerSettings, () {}),
            CustomListTile(Icons.info, t.drawerAbout, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
            }),
            CustomListTile(Icons.logout, t.drawerLogout, () {
              loginProvider.logout();
            }),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  CustomListTile(this.icon, this.text, this.onTap);

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
        child: InkWell(
          splashColor: Colors.lightGreen,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    )
                  ],
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
