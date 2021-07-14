import 'package:flutter/material.dart';
import 'package:fuel_tracker/Screens/About/about.dart';
import 'package:fuel_tracker/Screens/Some_screen/testScreen.dart';
import 'package:fuel_tracker/services/authentication_services/auth_services.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer(this.loginProvider);
  final AuthServices loginProvider;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(gradient: LinearGradient(colors: <Color>[Colors.green, Colors.lightGreen])),
              child: Text(
                'Dodatkowe funkcje',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
          CustomListTile(Icons.question_answer, 'Item 1', () {
            TestScreen();
          }),
          CustomListTile(Icons.question_answer, 'Item 2', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TestScreen()));
          }),
          CustomListTile(Icons.question_answer, 'Item 3', () {}),
          CustomListTile(Icons.settings, 'Ustawienia', () {}),
          CustomListTile(Icons.info, 'O aplikacji', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
          }),
          CustomListTile(Icons.logout, 'Wyloguj', () {
            loginProvider.logout();
          }),
        ],
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
