import 'package:flutter/material.dart';
import 'package:fuel_tracker/Screens/Avg_Prices/AvgPrices.dart';
import 'package:fuel_tracker/Screens/Calculator/calculator.dart';
import 'package:fuel_tracker/Screens/Petrol_map/PetrolMap.dart';

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
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment(0.0, 2), end: Alignment.topCenter, colors: <Color>[Theme.of(context).secondaryHeaderColor, Theme.of(context).primaryColor])),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Średnie ceny',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Stacje',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Kalkulator',
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
