import 'package:flutter/material.dart';
import 'package:fuel_tracker/screens/drawer/drawer.dart';
import 'package:fuel_tracker/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fuel_tracker/services/authentication_services/auth_services.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../Models/Country.dart';

class PricesAbroad extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PricesAbroad> {
  List<Country> countries = [];

  String removeSingsFromCountry(String text) {
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
    if (countries.isEmpty) {
      var response = await http.Client().get(Uri.parse('https://www.autocentrum.pl/paliwa/ceny-paliw/zagranica/'));

      var document = parse(response.body);

      var table = document.getElementsByClassName('country-petrol-rank');
      var tbody = table.first.getElementsByTagName('td');

      for (var i = 3; i < tbody.length;) {
        var name = removeSingsFromCountry(tbody[i++].text);
        var price95 = removeSingsFromPrice(tbody[i++].text);
        var priceON = removeSingsFromPrice(tbody[i++].text);

        var country = Country(name: name, price95: price95, priceON: priceON);

        countries.add(country);
      }
    }

    return countries;
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    final loginProvider = Provider.of<AuthServices>(context);
    return Scaffold(
        appBar: MyAppBar(context, t!.pricesAbroadTitle, false),
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
        ));
  }

  bool _isAscending = true;
  int _currentSortColumn = 0;

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
              columnSpacing: 30.0,
              horizontalMargin: 15,
              columns: <DataColumn>[
                displayCountryNameHeader(),
                displayPetrolHeader('assets/images/petrol95.png', '95'),
                displayPetrolHeader('assets/images/petrolON.png', 'ON'),
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
                onTap: () => launch('https://www.autocentrum.pl/paliwa/ceny-paliw/zagranica/'),
                child: Text('autocentrum.pl'),
              ),
            ),
          )
        ],
      ),
    );
  }

  DataColumn displayCountryNameHeader() {
    var t = AppLocalizations.of(context);
    return DataColumn(
        label: Text(
          t!.pricesAbroadTableTitle,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        onSort: (columnIndex, _) {
          setState(() {
            if (_isAscending == true) {
              _isAscending = false;
              _currentSortColumn = columnIndex;
              countries.sort((priceA, priceB) => priceB.name.compareTo(priceA.name));
            } else {
              _isAscending = true;
              _currentSortColumn = columnIndex;
              countries.sort((priceA, priceB) => priceA.name.compareTo(priceB.name));
            }
          });
        });
  }

  DataColumn displayPetrolHeader(String assetImage, String fuelType) {
    return DataColumn(
      label: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: AssetImage(assetImage),
          ),
        ),
      ),
      onSort: (columnIndex, _) {
        if (fuelType == '95') {
          setState(
            () {
              if (_isAscending == true) {
                _isAscending = false;
                _currentSortColumn = columnIndex;
                countries.sort((priceA, priceB) => priceB.price95.compareTo(priceA.price95));
              } else {
                _isAscending = true;
                _currentSortColumn = columnIndex;
                countries.sort((priceA, priceB) => priceA.price95.compareTo(priceB.price95));
              }
            },
          );
        } else if (fuelType == 'ON') {
          setState(
            () {
              if (_isAscending == true) {
                _isAscending = false;
                _currentSortColumn = columnIndex;
                countries.sort((priceA, priceB) => priceB.priceON.compareTo(priceA.priceON));
              } else {
                _isAscending = true;
                _currentSortColumn = columnIndex;
                countries.sort((priceA, priceB) => priceA.priceON.compareTo(priceB.priceON));
              }
            },
          );
        }
      },
    );
  }

  List<DataRow> getRowsWithPrices() {
    return countries
        .map(
          ((element) => DataRow(
                color: MaterialStateColor.resolveWith((states) {
                  return countries.indexOf(element) % 2 == 0 ? Theme.of(context).splashColor : Theme.of(context).primaryColorDark;
                }),
                cells: <DataCell>[
                  DataCell(
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 140,
                      ),
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/flags/' + element.name + '.png'),
                          Text(' ' + element.name),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    Text(element.price95, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataCell(
                    Text(element.priceON, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              )),
        )
        .toList();
  }
}
