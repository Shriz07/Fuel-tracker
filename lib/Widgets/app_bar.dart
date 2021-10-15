import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar MyAppBar(BuildContext context, String appBarTitle, bool appBarWithDrawer) {
  if (appBarWithDrawer) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text(appBarTitle, style: TextStyle(color: Colors.white)),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment(0.0, 2), colors: <Color>[Theme.of(context).secondaryHeaderColor, Theme.of(context).primaryColor])),
      ),
    );
  } else {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      title: Text(
        appBarTitle,
        style: TextStyle(color: Colors.white),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment(0.0, 2), colors: <Color>[Theme.of(context).secondaryHeaderColor, Theme.of(context).primaryColor])),
      ),
    );
  }
}
