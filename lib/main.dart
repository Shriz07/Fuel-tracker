import 'package:flutter/material.dart';
import 'package:fuel_tracker/Screens/Avg_Prices/AvgPrices.dart';
import 'package:fuel_tracker/Screens/Petrol_map/PetrolMap.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Fuel tracker';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    PetrolMap(),
    AvgPrices(),
    Text(
      'Index 2: ToDo',
      style: optionStyle,
    ),
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
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.green, Colors.green])),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(Icons.map),
              label: 'Stacje',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Średnie ceny',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attachment),
              label: 'ToDo',
              backgroundColor: Colors.purple,
            ),
          ],
          backgroundColor: Colors.transparent,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[300],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
