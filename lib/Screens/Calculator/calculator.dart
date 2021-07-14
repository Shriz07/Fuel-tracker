import 'package:flutter/material.dart';
import 'package:fuel_tracker/services/authentication_services/auth_services.dart';
import 'package:provider/provider.dart';

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
  double hundredCost = 0;

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
    final loginProvider = Provider.of<AuthServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator kosztów'),
        actions: [
          IconButton(onPressed: () async => await loginProvider.logout(), icon: Icon(Icons.exit_to_app)),
        ],
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
                    SizedBox(height: 30),
                    displayInputForm('Odległość', _distanceController, '(km)', Icon(Icons.add_road)),
                    SizedBox(height: 15),
                    displayInputForm('Cena', _priceController, '(zł/l)', Icon(Icons.attach_money)),
                    SizedBox(height: 15),
                    displayInputForm('Średnie spalanie', _consumptionController, '(l/100km)', Padding(padding: const EdgeInsets.all(14), child: Image.asset('assets/drop.png'))),
                    SizedBox(height: 30),
                    displayApplyButton(),
                    SizedBox(height: 40),
                    showResult == true ? displayCalculatedResult('Całkowity koszt przejazdu', totalCost.toStringAsFixed(2) + ' zł') : Container(),
                    SizedBox(height: 20),
                    showResult == true ? displayCalculatedResult('Koszt przejazdu 100km', hundredCost.toStringAsFixed(2) + ' zł') : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget displayCalculatedResult(String resultTitle, String result) {
    return Center(
      child: Column(children: [
        Text(
          resultTitle,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
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
                result,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget displayApplyButton() {
    return Center(
      child: MaterialButton(
        onPressed: () async {
          if (_formkey.currentState!.validate()) {
            setState(
              () {
                try {
                  totalCost = (double.parse(_distanceController.text) / 100) * double.parse(_consumptionController.text) * double.parse(_priceController.text);
                  hundredCost = double.parse(_consumptionController.text) * double.parse(_priceController.text);
                  showResult = true;
                } catch (e) {
                  print('Invalid format');
                }
                FocusScope.of(context).unfocus();
              },
            );
          }
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
    );
  }

  Widget displayInputForm(String inputName, TextEditingController inputController, String labelText, Widget? icon) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(inputName, style: TextStyle(fontSize: 17)),
          SizedBox(
            width: 15,
          ),
          Spacer(),
          Container(
            width: 200,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: inputController,
              validator: (val) => val!.isNotEmpty ? null : 'Podaj poprawną wartość',
              decoration: InputDecoration(
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.green, width: 3.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.blueAccent, width: 3.0),
                ),
                errorStyle: TextStyle(color: Colors.lightGreen, fontSize: 15),
                filled: true,
                fillColor: Colors.amberAccent,
                labelText: labelText,
                prefixIcon: icon,
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
    );
  }
}
