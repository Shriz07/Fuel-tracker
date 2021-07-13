import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Calculator> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController _distanceController;
  late TextEditingController _priceController;
  late TextEditingController _consumptionController;
  bool showResult = false;
  double totalCost = 0;

  @override
  void initState() {
    super.initState();
    _distanceController = TextEditingController();
    _priceController = TextEditingController();
    _consumptionController = TextEditingController();
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _priceController.dispose();
    _consumptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator kosztów'),
        /*actions: [
            IconButton(
                onPressed: () async => await loginProvider.logout(),
                icon: Icon(Icons.exit_to_app)),
          ],*/
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment(0.0, 2), colors: <Color>[Colors.green, Colors.lightGreen])),
        ),
      ),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Odległość', style: TextStyle(fontSize: 17)),
                          SizedBox(
                            width: 15,
                          ),
                          Spacer(),
                          Container(
                            width: 200,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _distanceController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.amberAccent,
                                labelText: '(km)',
                                prefixIcon: Icon(Icons.add_road),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(color: Colors.lightGreen, width: 3.0),
                                ),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Cena', style: TextStyle(fontSize: 17)),
                          SizedBox(
                            width: 15,
                          ),
                          Spacer(),
                          Container(
                            width: 200,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _priceController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.amberAccent,
                                labelText: '(zł/l)',
                                prefixIcon: Icon(Icons.attach_money),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(color: Colors.lightGreen, width: 3.0),
                                ),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Średnie spalanie', style: TextStyle(fontSize: 17)),
                          SizedBox(
                            width: 15,
                          ),
                          Spacer(),
                          Container(
                            width: 200,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _consumptionController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.amberAccent,
                                labelText: '(l/100 km)',
                                prefixIcon: Padding(padding: const EdgeInsets.all(14), child: Image.asset('assets/drop.png')),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(color: Colors.lightGreen, width: 3.0),
                                ),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    Center(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            totalCost = (double.parse(_distanceController.text) / 100) * double.parse(_consumptionController.text) * double.parse(_priceController.text);
                            showResult = true;
                          });
                        },
                        height: 50,
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'Oblicz koszt',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    showResult == true
                        ? Center(
                            child: Column(children: [
                              Text(
                                'Obliczony koszt przejazdu',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  border: Border.all(
                                    color: Colors.lightGreen,
                                    width: 3.0,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      totalCost.toStringAsFixed(2) + ' zł',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
