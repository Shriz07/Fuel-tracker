import 'package:flutter/material.dart';
import 'package:fuel_tracker/models/chart_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fuel_tracker/services/dark_mode/dark_theme_provider.dart';
import 'package:fuel_tracker/services/datetime_factory/localized_time_factory.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:url_launcher/url_launcher.dart';

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
    var t = AppLocalizations.of(context);
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(
              leading: Builder(
                builder: (context) => IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
              title: Text(
                t!.chartsNavbarTitle,
                style: TextStyle(color: Colors.white),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter, end: Alignment(0.0, 2), colors: <Color>[Theme.of(context).secondaryHeaderColor, Theme.of(context).primaryColor])),
              ),
              bottom: TabBar(
                indicatorColor: Theme.of(context).errorColor,
                tabs: [
                  Tab(
                      icon: Image.asset(
                    'assets/images/petrol95.png',
                    height: 35,
                  )),
                  Tab(
                      icon: Image.asset(
                    'assets/images/petrolON.png',
                    height: 35,
                  )),
                  Tab(
                      icon: Image.asset(
                    'assets/images/petrolLPG.png',
                    height: 35,
                  )),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              priceHistoryChart(t.charts95Title, _series95Price, 4.5, 6.5),
              priceHistoryChart(t.chartsONTitle, _seriesONPrice, 4.5, 6.5),
              priceHistoryChart(t.chartsLPGTitle, _seriesLPGPrice, 2, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget priceHistoryChart(String title, var dataSeries, double rangeStart, double rangeEnd) {
    var t = AppLocalizations.of(context);
    return Stack(
      children: <Widget>[
        Padding(
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
                          t!.chartsXLabel,
                          behaviorPosition: charts.BehaviorPosition.bottom,
                          titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                          titleStyleSpec: charts.TextStyleSpec(
                            color: charts.ColorUtil.fromDartColor(Theme.of(context).errorColor),
                          ),
                        ),
                        charts.ChartTitle(
                          t.chartsYLabel,
                          behaviorPosition: charts.BehaviorPosition.start,
                          titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                          titleStyleSpec: charts.TextStyleSpec(
                            color: charts.ColorUtil.fromDartColor(Theme.of(context).errorColor),
                          ),
                        ),
                        charts.PanAndZoomBehavior(),
                      ],
                      selectionModels: [
                        charts.SelectionModelConfig(changedListener: (charts.SelectionModel model) {
                          if (model.hasDatumSelection) {
                            print(model.selectedSeries[0].measureFn(model.selectedDatum[0].index));
                          }
                        })
                      ],
                      dateTimeFactory: LocalizedTimeFactory(Localizations.localeOf(context)),
                      domainAxis: charts.DateTimeAxisSpec(
                        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                          month: charts.TimeFormatterSpec(format: 'MMMd', transitionFormat: 'MMMd'),
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
                        tickProviderSpec: charts.StaticNumericTickProviderSpec([
                          charts.TickSpec(1.0),
                          charts.TickSpec(1.5),
                          charts.TickSpec(2.0),
                          charts.TickSpec(2.5),
                          charts.TickSpec(3.0),
                          charts.TickSpec(3.5),
                          charts.TickSpec(4.0),
                          charts.TickSpec(4.5),
                          charts.TickSpec(5.0),
                          charts.TickSpec(5.5),
                          charts.TickSpec(6.0),
                          charts.TickSpec(6.5),
                          charts.TickSpec(7.0),
                          charts.TickSpec(7.5),
                          charts.TickSpec(8.0),
                          charts.TickSpec(8.5),
                          charts.TickSpec(9.0),
                        ]),
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
    );
  }
}

class Price {
  Price(this.data, this.price);

  DateTime data;
  double price;
}
