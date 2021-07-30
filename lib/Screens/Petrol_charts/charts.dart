import 'package:flutter/material.dart';
import 'package:fuel_tracker/Screens/Petrol_charts/chartData.dart';
import 'package:fuel_tracker/services/dark_mode/darkThemeProvider.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Charts extends StatefulWidget {
  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  late List<charts.Series<Price, DateTime>> _series95Price = [];
  late List<charts.Series<Price, DateTime>> _seriesONPrice = [];
  late List<charts.Series<Price, DateTime>> _seriesLPGPrice = [];
  final data95 = [];
  var chartData;
  bool initialized = false;

  Future<bool> getChartData() async {
    if (!initialized) {
      chartData = 1;
      var response = await http.Client().get(Uri.parse('https://www.autocentrum.pl/paliwa/ceny-paliw/'));

      var document = parse(response.body);

      var chartDataText = document.getElementById('price-chart')!.attributes['data-chart'];

      chartData = ChartData.fromRawJson(chartDataText!);
      initialized = true;
    }

    List<Price> data95 = [];
    List<Price> dataON = [];
    List<Price> dataLPG = [];

    for (final x in chartData.datasets) {
      var i = 0;
      for (final z in x.data) {
        var data1 = Price(chartData.labels[i], z);
        i++;
        if (x.label == 'Polska 95') {
          data95.add(data1);
        } else if (x.label == 'Polska ON') {
          dataON.add(data1);
        } else {
          dataLPG.add(data1);
        }
      }
    }

    _series95Price.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Theme.of(context).primaryColor),
        id: '500',
        data: data95,
        domainFn: (Price price, _) => price.data,
        measureFn: (Price price, _) => price.price,
      ),
    );

    _seriesONPrice.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Theme.of(context).primaryColor),
        id: '500',
        data: dataON,
        domainFn: (Price price, _) => price.data,
        measureFn: (Price price, _) => price.price,
      ),
    );

    _seriesLPGPrice.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Theme.of(context).primaryColor),
        id: '500',
        data: dataLPG,
        domainFn: (Price price, _) => price.data,
        measureFn: (Price price, _) => price.price,
      ),
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return FutureBuilder<bool>(
      future: getChartData(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data != null) {
          return displayChart();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget displayChart() {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Historia cen'),
            /*actions: [
              IconButton(
                  onPressed: () {
                    themeChange.darkTheme = !themeChange.darkTheme;
                  },
                  icon: Icon(Icons.dark_mode_outlined)),
            ],*/
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(begin: Alignment.topCenter, end: Alignment(0.0, 2), colors: <Color>[Theme.of(context).secondaryHeaderColor, Theme.of(context).primaryColor])),
            ),
            bottom: TabBar(
              indicatorColor: Theme.of(context).secondaryHeaderColor,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Tab(icon: Image.asset('assets/petrol95.png')),
                ),
                Tab(icon: Image.asset('assets/petrolON.png')),
                Tab(icon: Image.asset('assets/petrolLPG.png')),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: charts.TimeSeriesChart(
                            _series95Price,
                            defaultRenderer: charts.LineRendererConfig(includeArea: true, stacked: true),
                            animate: true,
                            animationDuration: Duration(seconds: 1),
                            behaviors: [
                              charts.ChartTitle('Date', behaviorPosition: charts.BehaviorPosition.bottom, titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                              charts.ChartTitle('Cena', behaviorPosition: charts.BehaviorPosition.start, titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: charts.TimeSeriesChart(
                            _seriesONPrice,
                            defaultRenderer: charts.LineRendererConfig(includeArea: true, stacked: true),
                            animate: true,
                            animationDuration: Duration(seconds: 1),
                            behaviors: [
                              charts.ChartTitle('Date', behaviorPosition: charts.BehaviorPosition.bottom, titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                              charts.ChartTitle('Cena', behaviorPosition: charts.BehaviorPosition.start, titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: charts.TimeSeriesChart(
                            _seriesLPGPrice,
                            defaultRenderer: charts.LineRendererConfig(includeArea: true, stacked: true),
                            animate: true,
                            animationDuration: Duration(seconds: 1),
                            behaviors: [
                              charts.ChartTitle('Date', behaviorPosition: charts.BehaviorPosition.bottom, titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                              charts.ChartTitle('Cena', behaviorPosition: charts.BehaviorPosition.start, titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Price {
  Price(this.data, this.price);

  DateTime data;
  double price;
}
