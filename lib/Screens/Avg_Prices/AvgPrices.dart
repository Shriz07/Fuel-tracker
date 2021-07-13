import 'package:flutter/material.dart';
import 'package:fuel_tracker/Screens/Avg_Prices/Region.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

final List<String> fuel_types = [
  '95',
  '98',
  'ON',
  'ON+',
  'LPG',
];

class AvgPrices extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

//TODO add response 200 handling https://medium.com/flutter-community/parsing-html-in-dart-with-html-package-cd43c29cc460
class _MyAppState extends State<AvgPrices> {
  List<Region> regions = [];

  String removeSingsFromRregion(String text) {
    text = text.replaceAll(' ', '');
    text = text.replaceAll('\n', '');
    return text;
  }

  String removeSingsFromPrice(String text) {
    text = text.replaceAll(' ', '');
    text = text.replaceAll('\n', '');
    text = text.replaceAll('-', 'b.d.');
    return text;
  }

  Future<List> getPrices() async {
    if (regions.isEmpty) {
      var response = await http.Client()
          .get(Uri.parse('https://www.autocentrum.pl/paliwa/ceny-paliw/'));

      var document = parse(response.body);

      var table = document.getElementsByClassName('petrols-table');
      var tbody = table.first.getElementsByTagName('td');

      for (var i = 0; i < tbody.length;) {
        var name = removeSingsFromRregion(tbody[i++].text);

        var price95 = removeSingsFromPrice(tbody[i++].text);
        var price98 = removeSingsFromPrice(tbody[i++].text);
        var priceON = removeSingsFromPrice(tbody[i++].text);
        var priceONplus = removeSingsFromPrice(tbody[i++].text);
        var priceLPG = removeSingsFromPrice(tbody[i++].text);

        var petrol = Region(
            name: name,
            price95: price95,
            price98: price98,
            priceON: priceON,
            priceONplus: priceONplus,
            priceLPG: priceLPG);

        regions.add(petrol);
      }
    }
    return regions;
  }

  bool _isAscending = true;
  int _currentSortColumn = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: getPrices(),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.data != null) {
            return getTableContent();
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Padding getTableContent() {
    return Padding(
      padding: EdgeInsets.only(top: 24.0),
      child: ConstrainedBox(
        constraints:
            BoxConstraints.expand(width: MediaQuery.of(context).size.width),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            sortAscending: _isAscending,
            sortColumnIndex: _currentSortColumn,
            columnSpacing: 0,
            horizontalMargin: 15,
            headingRowColor:
                MaterialStateColor.resolveWith((states) => Colors.green),
            columns: <DataColumn>[
              DataColumn(
                  label: Text(
                    'Województwo',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  onSort: (columnIndex, _) {
                    setState(() {
                      if (_isAscending == true) {
                        _isAscending = false;
                        _currentSortColumn = columnIndex;
                        regions.sort((priceA, priceB) =>
                            priceB.name.compareTo(priceA.name));
                      } else {
                        _isAscending = true;
                        _currentSortColumn = columnIndex;
                        regions.sort((priceA, priceB) =>
                            priceA.name.compareTo(priceB.name));
                      }
                    });
                  }),
              DataColumn(
                  label: Expanded(
                      child: Image(
                    image: AssetImage('assets/petrol95.png'),
                  )),
                  onSort: (columnIndex, _) {
                    setState(() {
                      if (_isAscending == true) {
                        _isAscending = false;
                        _currentSortColumn = columnIndex;
                        regions.sort((priceA, priceB) =>
                            priceB.price95.compareTo(priceA.price95));
                      } else {
                        _isAscending = true;
                        _currentSortColumn = columnIndex;
                        regions.sort((priceA, priceB) =>
                            priceA.price95.compareTo(priceB.price95));
                      }
                    });
                  }),
              DataColumn(
                  label: Expanded(
                    child: Image(
                      image: AssetImage('assets/petrol98.png'),
                    ),
                  ),
                  onSort: (columnIndex, _) {
                    setState(() {
                      if (_isAscending == true) {
                        _isAscending = false;
                        _currentSortColumn = columnIndex;
                        regions.sort((priceA, priceB) =>
                            priceB.price98.compareTo(priceA.price98));
                      } else {
                        _isAscending = true;
                        _currentSortColumn = columnIndex;
                        regions.sort((priceA, priceB) =>
                            priceA.price98.compareTo(priceB.price98));
                      }
                    });
                  }),
              DataColumn(
                  label: Expanded(
                    child: Image(
                      image: AssetImage('assets/petrolON.png'),
                    ),
                  ),
                  onSort: (columnIndex, _) {
                    setState(() {
                      if (_isAscending == true) {
                        _isAscending = false;
                        _currentSortColumn = columnIndex;
                        regions.sort((priceA, priceB) =>
                            priceB.priceON.compareTo(priceA.priceON));
                      } else {
                        _isAscending = true;
                        _currentSortColumn = columnIndex;
                        regions.sort((priceA, priceB) =>
                            priceA.priceON.compareTo(priceB.priceON));
                      }
                    });
                  }),
              DataColumn(
                  label: Expanded(
                    child: Image(
                      image: AssetImage('assets/petrolONplus.png'),
                    ),
                  ),
                  onSort: (columnIndex, _) {
                    setState(() {
                      if (_isAscending == true) {
                        _isAscending = false;
                        _currentSortColumn = columnIndex;
                        regions.sort((priceA, priceB) =>
                            priceB.priceONplus.compareTo(priceA.priceONplus));
                      } else {
                        _isAscending = true;
                        _currentSortColumn = columnIndex;
                        regions.sort((priceA, priceB) =>
                            priceA.priceONplus.compareTo(priceB.priceONplus));
                      }
                    });
                  }),
              DataColumn(
                  label: Expanded(
                    child: Image(
                      image: AssetImage('assets/petrolLPG.png'),
                    ),
                  ),
                  onSort: (columnIndex, _) {
                    setState(() {
                      if (_isAscending == true) {
                        _isAscending = false;
                        _currentSortColumn = columnIndex;
                        regions.sort((priceA, priceB) =>
                            priceB.priceLPG.compareTo(priceA.priceLPG));
                      } else {
                        _isAscending = true;
                        _currentSortColumn = columnIndex;
                        regions.sort((priceA, priceB) =>
                            priceA.priceLPG.compareTo(priceB.priceLPG));
                      }
                    });
                  }),
            ],
            rows: regions
                .map(
                  ((element) => DataRow(
                        color: MaterialStateColor.resolveWith((states) {
                          return regions.indexOf(element) % 2 == 0
                              ? Colors.amberAccent
                              : Colors.lightGreen;
                        }),
                        cells: <DataCell>[
                          DataCell(
                            Text(element.name, textAlign: TextAlign.center),
                          ),
                          DataCell(
                            Text(element.price95, textAlign: TextAlign.center),
                          ),
                          DataCell(
                            Text(element.price98, textAlign: TextAlign.center),
                          ),
                          DataCell(
                            Text(element.priceON, textAlign: TextAlign.center),
                          ),
                          DataCell(
                            Text(element.priceONplus,
                                textAlign: TextAlign.center),
                          ),
                          DataCell(
                            Text(element.priceLPG, textAlign: TextAlign.center),
                          ),
                        ],
                      )),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
