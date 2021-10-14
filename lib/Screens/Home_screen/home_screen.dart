import 'package:flutter/material.dart';
import 'package:fuel_tracker/Screens/Avg_Prices/avg_prices.dart';
import 'package:fuel_tracker/Screens/Calculator/calculator.dart';
import 'package:fuel_tracker/Screens/Petrol_map/petrol_map.dart';
import 'package:fuel_tracker/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    AvgPrices(),
    PetrolMap(),
    Calculator(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment(0.0, 2), end: Alignment.topCenter, colors: <Color>[Theme.of(context).secondaryHeaderColor, Theme.of(context).primaryColor])),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: t!.navbar1Item,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: t.navbar2Item,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: t.navbar3Item,
            ),
          ],
          backgroundColor: Colors.transparent,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
