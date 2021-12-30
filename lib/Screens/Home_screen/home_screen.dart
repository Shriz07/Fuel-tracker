import 'package:flutter/material.dart';
import 'package:fuel_tracker/screens/avg_prices/avg_prices.dart';
import 'package:fuel_tracker/screens/calculator/calculator.dart';
import 'package:fuel_tracker/screens/petrol_map/petrol_map.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
        child: CurvedNavigationBar(
          items: <Widget>[
            Icon(
              Icons.attach_money,
              color: Colors.white,
              size: 30.0,
            ),
            Icon(
              Icons.map,
              color: Colors.white,
              size: 30.0,
            ),
            Icon(
              Icons.calculate,
              color: Colors.white,
              size: 30.0,
            ),
          ],
          onTap: (index) {
            _onItemTapped(index);
          },
          backgroundColor: Theme.of(context).backgroundColor,
          color: Theme.of(context).primaryColor,
          height: 55.0,
        ),
      ),
    );
  }
}
