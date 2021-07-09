import 'package:flutter/material.dart';
import 'package:fuel_tracker/Screens/Avg_Prices/Price.dart';
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
  var prices = [];

  Future<void> getPrices() async {
    var response = await http.Client()
        .get(Uri.parse('https://www.autocentrum.pl/paliwa/ceny-paliw/'));

    var document = parse(response.body);

    var table = document.getElementsByClassName('petrols-table');
    var tbody = table.first.getElementsByTagName('td');

    //List<Price> prices;
    for (var i = 0; i < tbody.length;) {
      var region = tbody[i++].text;
      region = region.replaceAll(' ', '');

      for (var j = 0; j < 5; j++) {
        var price = tbody[i++].text;
        price = price.replaceAll(' ', '');
        price = price.replaceAll('\n', '');
        var petrol = Price(price: price, type: fuel_types[j], region: region);
        prices.add(petrol);
      }
    }

    prices.forEach((element) {
      print(element.region);
    });
  }

  @override
  Widget build(BuildContext context) {
    getPrices();
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ConstrainedBox(
        constraints:
            BoxConstraints.expand(width: MediaQuery.of(context).size.width),
        child: DataTable(
          columnSpacing: 0,
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Województwo',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                '95',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                '98',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'ON',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'ON+',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'LPG',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: const <DataRow>[],
        ),
      ),
    );
  }
}
