import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fuel_tracker/Screens/Drawer/drawer.dart';
import 'package:fuel_tracker/Screens/Petrol_map/locations.dart';
import 'package:fuel_tracker/Widgets/app_bar.dart';
import 'package:fuel_tracker/Widgets/popup_dialog.dart';
import 'package:fuel_tracker/l10n/app_localizations.dart';
import 'package:fuel_tracker/services/authentication_services/auth_services.dart';
import 'package:fuel_tracker/services/dark_mode/dark_theme_provider.dart';
import 'package:fuel_tracker/services/firestore_services/firestore_db.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'locations.dart' as locations;
import 'package:time_ago_provider/time_ago_provider.dart' as timeAgo;

class PetrolMap extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PetrolMap> with WidgetsBindingObserver {
  final Completer<GoogleMapController> _controller = Completer();
  final FirebaseAuth auth = FirebaseAuth.instance;
  late BitmapDescriptor petrolMarker;
  late BitmapDescriptor dropIcon;
  var geolocator = Geolocator();
  final _formkey = GlobalKey<FormState>();
  late TextEditingController _petrol95Controller;
  late TextEditingController _petrol98Controller;
  late TextEditingController _petrolONController;
  late TextEditingController _petrolLPGController;
  final FirestoreDB _db = FirestoreDB();
  String _darkMapStyle = '';
  String _lightMapStyle = '';
  bool isDark = false;

  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _loadMapStyles();
    _petrol95Controller = TextEditingController();
    _petrol98Controller = TextEditingController();
    _petrolONController = TextEditingController();
    _petrolLPGController = TextEditingController();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/petrol-marker.png').then((value) => petrolMarker = value);
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/drop.png').then((value) => dropIcon = value);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _petrol95Controller.dispose();
    _petrol98Controller.dispose();
    _petrolONController.dispose();
    _petrolLPGController.dispose();
    super.dispose();
  }

  Future _setMapStyle() async {
    final controller = await _controller.future;

    if (isDark == true) {
      await controller.setMapStyle(_darkMapStyle);
    } else {
      await controller.setMapStyle(_lightMapStyle);
    }
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/map_styles/map_dark.json');
    _lightMapStyle = await rootBundle.loadString('assets/map_styles/map_light.json');
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    await _setMapStyle();
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    var latlng = LatLng(position.latitude, position.longitude);

    var cameraPosition = CameraPosition(target: latlng, zoom: 12);

    await controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    final petrolStations;
    try {
      petrolStations = await locations.getPetrolStations(position.latitude, position.longitude);
    } catch (e) {
      var t = AppLocalizations.of(context);
      await showDialog(
        context: context,
        builder: (BuildContext context) => PopupDialog(
          title: t!.petrolMapWarningTitle,
          message: t.petrolMapWarningNoInternet, //Message informing that user has no internet connection
          close: t.petrolMapWarningClose,
        ),
      );
      return;
    }
    setState(() {
      _markers.clear();
      for (final station in petrolStations.stations) {
        final marker = Marker(
          onTap: () {
            _showDialog(station);
          },
          icon: petrolMarker,
          markerId: MarkerId(station.name),
          position: LatLng(station.geometry.location.lat, station.geometry.location.lng),
          infoWindow: InfoWindow(
            title: station.name,
          ),
        );
        _markers[station.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final loginProvider = Provider.of<AuthServices>(context);
    isDark = themeChange.darkTheme;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(t!.petrolMapTitle, style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  themeChange.darkTheme = !themeChange.darkTheme;
                  isDark = themeChange.darkTheme;
                  _setMapStyle();
                });
              },
              icon: Icon(Icons.dark_mode_outlined),
              color: Colors.white),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(begin: Alignment.topCenter, end: Alignment(0.0, 2), colors: <Color>[Theme.of(context).secondaryHeaderColor, Theme.of(context).primaryColor])),
        ),
      ),
      drawer: MyDrawer(loginProvider),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: const LatLng(51.7592, 19.4560),
          zoom: 4,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }

  void _showDialog(Station station) async {
    var t = AppLocalizations.of(context);
    var check = await _db.getStation(station);

    if (check == false) {
      await showDialog(
        context: context,
        builder: (BuildContext context) => PopupDialog(
          title: t!.petrolMapWarningTitle,
          message: t.petrolMapWarningNoInternet, //Message informing that user has no internet connection
          close: t.petrolMapWarningClose,
        ),
      );
    } else {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          displayTitle(station.name, context),
                          SizedBox(height: 10),
                          displayStationAddress(station.vicinity),
                          SizedBox(height: 10),
                          ratingBarIndicator(station.rating),
                          SizedBox(height: 10),
                          lastUpdateText(station),
                          SizedBox(height: 10),
                          PetrolInputField('assets/petrol95.png', station.price95, _petrol95Controller),
                          SizedBox(height: 15),
                          PetrolInputField('assets/petrol98.png', station.price98, _petrol98Controller),
                          SizedBox(height: 15),
                          PetrolInputField('assets/petrolON.png', station.priceON, _petrolONController),
                          SizedBox(height: 15),
                          PetrolInputField('assets/petrolLPG.png', station.priceLPG, _petrolLPGController),
                          SizedBox(height: 30),
                          saveButton(station, context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  Widget displayTitle(String title, BuildContext currContext) {
    return Row(
      children: <Widget>[
        goBackButton(currContext),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 32),
            child: displayStationName(title),
          ),
        ),
      ],
    );
  }

  Widget displayStationName(String name) {
    return Title(
      color: Colors.black,
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget goBackButton(BuildContext currContext) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.lightGreen,
        size: 30,
      ),
      onPressed: () {
        Navigator.pop(currContext);
      },
    );
  }

  Widget displayStationAddress(String address) {
    return Text(
      address,
      style: TextStyle(fontSize: 16),
    );
  }

  Widget ratingBarIndicator(double rating) {
    return RatingBarIndicator(
      itemSize: 30.0,
      rating: rating,
      itemCount: 5,
      direction: Axis.horizontal,
      itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
    );
  }

  Widget lastUpdateText(Station station) {
    var t = AppLocalizations.of(context);
    var dateTime1 = DateTime.now();
    var dateTime2 = DateTime.fromMicrosecondsSinceEpoch(station.updateTimestamp.microsecondsSinceEpoch);
    var differenceBetweenDates = dateTime1.difference(dateTime2).inDays;
    return Center(
      child: differenceBetweenDates > 10000
          ? Text(t!.petrolMapLastUpdateNever)
          : Text(
              t!.petrolMapLastUpdate + timeAgo.format(station.updateTimestamp.toDate(), locale: 'pl'),
            ),
    );
  }

  Widget saveButton(Station station, BuildContext currContext) {
    var t = AppLocalizations.of(context);
    return Center(
      child: MaterialButton(
        onPressed: () {
          updatePrices(station);
        },
        height: 50,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          t!.petrolMapSave,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void updatePrices(Station station) {
    var t = AppLocalizations.of(context);
    final user = auth.currentUser;
    final uid = user!.uid;
    var dataChanged = false;
    if (validatePrice(_petrol95Controller.text, '95')) {
      var stringPriceFixed = double.parse(_petrol95Controller.text).toStringAsFixed(2);
      station.price95 = stringPriceFixed;
      dataChanged = true;
    }
    if (validatePrice(_petrol98Controller.text, '98')) {
      var stringPriceFixed = double.parse(_petrol98Controller.text).toStringAsFixed(2);
      station.price98 = stringPriceFixed;
      dataChanged = true;
    }
    if (validatePrice(_petrolONController.text, 'ON')) {
      var stringPriceFixed = double.parse(_petrolONController.text).toStringAsFixed(2);
      station.priceON = stringPriceFixed;
      dataChanged = true;
    }
    if (validatePrice(_petrolLPGController.text, 'LPG')) {
      var stringPriceFixed = double.parse(_petrolLPGController.text).toStringAsFixed(2);
      station.priceLPG = stringPriceFixed;
      dataChanged = true;
    }
    if (dataChanged) {
      station.updateUserID = uid;
      _db.addStation(station);
      Navigator.of(context).pop();
    } else {
      showDialog(
          context: context, builder: (BuildContext context) => PopupDialog(title: t!.petrolMapWarningTitle, message: t.petrolMapWarningMessage, close: t.petrolMapWarningClose));
    }
    _petrol95Controller.text = '';
    _petrol98Controller.text = '';
    _petrolONController.text = '';
    _petrolLPGController.text = '';
  }

  bool validatePrice(String price, String fuelType) {
    if (price == '') return false;

    var doublePrice;
    try {
      doublePrice = double.parse(price);
    } catch (e) {
      return false;
    }

    if (fuelType == '95' || fuelType == '98' || fuelType == 'ON') {
      if (doublePrice < 4 || doublePrice > 7) return false;
    }
    if (fuelType == 'LPG') {
      if (doublePrice < 1 || doublePrice > 4) return false;
    }

    return true;
  }

  double roundDouble(double val, int places) {
    var mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }
}

class PetrolInputField extends StatelessWidget {
  PetrolInputField(this.imageAsset, this.price, this.textController);

  final String imageAsset;
  final String price;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(imageAsset),
          ),
          SizedBox(width: 15),
          Flexible(
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: textController,
              decoration: InputDecoration(
                filled: true,
                hintText: price,
                prefixIcon: Padding(padding: const EdgeInsets.all(8), child: Image.asset('assets/drop.png')),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}