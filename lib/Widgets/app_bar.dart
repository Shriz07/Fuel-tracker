import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/services/dark_mode/dark_theme_provider.dart';
import 'package:provider/provider.dart';

AppBar MyAppBar(BuildContext context, String appBarTitle) {
  final themeChange = Provider.of<DarkThemeProvider>(context);
  return AppBar(
    leading: Builder(
      builder: (context) => IconButton(
        icon: Icon(Icons.menu, color: Colors.white),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
    title: Text(
      appBarTitle,
      style: TextStyle(color: Colors.white),
    ),
    actions: [
      IconButton(
          onPressed: () {
            themeChange.darkTheme = !themeChange.darkTheme;
          },
          icon: Icon(
            Icons.dark_mode_outlined,
            color: Colors.white,
          )),
    ],
    flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment(0.0, 2), colors: <Color>[Theme.of(context).secondaryHeaderColor, Theme.of(context).primaryColor])),
    ),
  );
}
