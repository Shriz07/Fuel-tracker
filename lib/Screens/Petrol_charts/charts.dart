import 'package:flutter/material.dart';
import 'package:fuel_tracker/Screens/Petrol_charts/chartData.dart';
import 'package:fuel_tracker/services/dark_mode/darkThemeProvider.dart';
import 'package:fuel_tracker/services/datetime_factory/localizedTimeFactory.dart';
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
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text('Historia cen'),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(begin: Alignment.topCenter, end: Alignment(0.0, 2), colors: <Color>[Theme.of(context).secondaryHeaderColor, Theme.of(context).primaryColor])),
            ),
            bottom: TabBar(
              indicatorColor: Theme.of(context).errorColor,
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
              priceHistoryChart('Cena benzyny w ostatnich 3 miesiącach', _series95Price, 3, 7),
              priceHistoryChart('Cena oleju napędowego w ostatnich 3 miesiącach', _seriesONPrice, 3, 7),
              priceHistoryChart('Cena gazu w ostatnich 3 miesiącach', _seriesLPGPrice, 1, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget priceHistoryChart(String title, var dataSeries, int rangeStart, int rangeEnd) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Theme.of(context).errorColor),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: charts.TimeSeriesChart(
                  dataSeries,
                  defaultRenderer: charts.LineRendererConfig(includeArea: true, stacked: true),
                  animate: true,
                  animationDuration: Duration(seconds: 1),
                  behaviors: [
                    charts.ChartTitle(
                      'Data',
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                      titleStyleSpec: charts.TextStyleSpec(
                        color: charts.ColorUtil.fromDartColor(Theme.of(context).errorColor),
                      ),
                    ),
                    charts.ChartTitle(
                      'Cena (zł/l)',
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                      titleStyleSpec: charts.TextStyleSpec(
                        color: charts.ColorUtil.fromDartColor(Theme.of(context).errorColor),
                      ),
                    ),
                    charts.PanAndZoomBehavior(),
                  ],
                  dateTimeFactory: LocalizedTimeFactory(Localizations.localeOf(context)),
                  domainAxis: charts.DateTimeAxisSpec(
                    tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                      month: charts.TimeFormatterSpec(format: 'mm', transitionFormat: 'mm'),
                    ),
                    renderSpec: charts.SmallTickRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        color: charts.ColorUtil.fromDartColor(Theme.of(context).errorColor),
                        fontSize: 15,
                      ),
                      lineStyle: charts.LineStyleSpec(
                        color: charts.ColorUtil.fromDartColor(Theme.of(context).errorColor),
                      ),
                    ),
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    viewport: charts.NumericExtents(rangeStart, rangeEnd),
                    renderSpec: charts.GridlineRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        color: charts.ColorUtil.fromDartColor(Theme.of(context).errorColor),
                        fontSize: 15,
                      ),
                      lineStyle: charts.LineStyleSpec(
                        color: charts.ColorUtil.fromDartColor(Theme.of(context).errorColor),
                      ),
                    ),
                  ),
                ),
              )
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
