import 'package:flutter/material.dart';
import 'package:fuel_tracker/Screens/Avg_Prices/Region.dart';
import 'package:fuel_tracker/Screens/Drawer/drawer.dart';
import 'package:fuel_tracker/Widgets/app_bar.dart';
import 'package:fuel_tracker/l10n/app_localizations.dart';
import 'package:fuel_tracker/services/authentication_services/auth_services.dart';
import 'package:fuel_tracker/services/dark_mode/dark_theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

  String removeSingsFromRegion(String text) {
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
      var response = await http.Client().get(Uri.parse('https://www.autocentrum.pl/paliwa/ceny-paliw/'));

      var document = parse(response.body);

      var table = document.getElementsByClassName('petrols-table');
      var tbody = table.first.getElementsByTagName('td');

      for (var i = 0; i < tbody.length;) {
        var name = removeSingsFromRegion(tbody[i++].text);

        var price95 = removeSingsFromPrice(tbody[i++].text);
        var price98 = removeSingsFromPrice(tbody[i++].text);
        var priceON = removeSingsFromPrice(tbody[i++].text);
        var priceONplus = removeSingsFromPrice(tbody[i++].text);
        var priceLPG = removeSingsFromPrice(tbody[i++].text);

        var petrol = Region(name: name, price95: price95, price98: price98, priceON: priceON, priceONplus: priceONplus, priceLPG: priceLPG);

        regions.add(petrol);
      }
    }
    return regions;
  }

  bool _isAscending = true;
  int _currentSortColumn = 0;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final loginProvider = Provider.of<AuthServices>(context);
    var t = AppLocalizations.of(context);
    return Scaffold(
      appBar: MyAppBar(context, t!.avgPricesTitle, true),
      drawer: MyDrawer(loginProvider),
      body: FutureBuilder<List>(
        future: getPrices(),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.data != null) {
            return getTableContent();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget getTableContent() {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width),
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              sortAscending: _isAscending,
              sortColumnIndex: _currentSortColumn,
              columnSpacing: 0,
              horizontalMargin: 15,
              columns: <DataColumn>[
                displayRegionNameHeader(),
                displayPetrolHeader('assets/petrol95.png', '95'),
                displayPetrolHeader('assets/petrol98.png', '98'),
                displayPetrolHeader('assets/petrolON.png', 'ON'),
                displayPetrolHeader('assets/petrolONplus.png', 'ONplus'),
                displayPetrolHeader('assets/petrolLPG.png', 'LPG'),
              ],
              rows: getRowsWithPrices(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.all(3.0),
              color: Theme.of(context).highlightColor,
              child: InkWell(
                onTap: () => launch('https://www.autocentrum.pl/paliwa/ceny-paliw/'),
                child: Text('autocentrum.pl'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataRow> getRowsWithPrices() {
    return regions
        .map(
          ((element) => DataRow(
                color: MaterialStateColor.resolveWith((states) {
                  return regions.indexOf(element) % 2 == 0 ? Theme.of(context).splashColor : Theme.of(context).primaryColorDark;
                }),
                cells: <DataCell>[
                  DataCell(
                    Text(
                      element.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(element.price95, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataCell(
                    Text(element.price98, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataCell(
                    Text(element.priceON, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataCell(
                    Text(element.priceONplus, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataCell(
                    Text(element.priceLPG, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              )),
        )
        .toList();
  }

  DataColumn displayRegionNameHeader() {
    var t = AppLocalizations.of(context);
    return DataColumn(
        label: Text(
          t!.avgPricesTableTitle,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        onSort: (columnIndex, _) {
          setState(() {
            if (_isAscending == true) {
              _isAscending = false;
              _currentSortColumn = columnIndex;
              regions.sort((priceA, priceB) => priceB.name.compareTo(priceA.name));
            } else {
              _isAscending = true;
              _currentSortColumn = columnIndex;
              regions.sort((priceA, priceB) => priceA.name.compareTo(priceB.name));
            }
          });
        });
  }

  DataColumn displayPetrolHeader(String assetImage, String fuelType) {
    return DataColumn(
      label: Expanded(
        child: Image(
          image: AssetImage(assetImage),
        ),
      ),
      onSort: (columnIndex, _) {
        if (fuelType == 'LPG') {
          setState(
            () {
              if (_isAscending == true) {
                _isAscending = false;
                _currentSortColumn = columnIndex;
                regions.sort((priceA, priceB) => priceB.priceLPG.compareTo(priceA.priceLPG));
              } else {
                _isAscending = true;
                _currentSortColumn = columnIndex;
                regions.sort((priceA, priceB) => priceA.priceLPG.compareTo(priceB.priceLPG));
              }
            },
          );
        } else if (fuelType == '95') {
          setState(
            () {
              if (_isAscending == true) {
                _isAscending = false;
                _currentSortColumn = columnIndex;
                regions.sort((priceA, priceB) => priceB.price95.compareTo(priceA.price95));
              } else {
                _isAscending = true;
                _currentSortColumn = columnIndex;
                regions.sort((priceA, priceB) => priceA.price95.compareTo(priceB.price95));
              }
            },
          );
        } else if (fuelType == '98') {
          setState(
            () {
              if (_isAscending == true) {
                _isAscending = false;
                _currentSortColumn = columnIndex;
                regions.sort((priceA, priceB) => priceB.price98.compareTo(priceA.price98));
              } else {
                _isAscending = true;
                _currentSortColumn = columnIndex;
                regions.sort((priceA, priceB) => priceA.price98.compareTo(priceB.price98));
              }
            },
          );
        } else if (fuelType == 'ON') {
          setState(
            () {
              if (_isAscending == true) {
                _isAscending = false;
                _currentSortColumn = columnIndex;
                regions.sort((priceA, priceB) => priceB.priceON.compareTo(priceA.priceON));
              } else {
                _isAscending = true;
                _currentSortColumn = columnIndex;
                regions.sort((priceA, priceB) => priceA.priceON.compareTo(priceB.priceON));
              }
            },
          );
        } else if (fuelType == 'ONplus') {
          setState(
            () {
              if (_isAscending == true) {
                _isAscending = false;
                _currentSortColumn = columnIndex;
                regions.sort((priceA, priceB) => priceB.priceONplus.compareTo(priceA.priceONplus));
              } else {
                _isAscending = true;
                _currentSortColumn = columnIndex;
                regions.sort((priceA, priceB) => priceA.priceONplus.compareTo(priceB.priceONplus));
              }
            },
          );
        }
      },
    );
  }
}
