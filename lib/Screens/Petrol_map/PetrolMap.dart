import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fuel_tracker/Screens/Petrol_map/locations.dart';
import 'package:fuel_tracker/services/authentication_services/auth_services.dart';
import 'package:fuel_tracker/services/firestore_services/firestoreDB.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'locations.dart' as locations;

class PetrolMap extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PetrolMap> {
  Position? _currentPosition;
  late BitmapDescriptor myIcon;
  late BitmapDescriptor dropIcon;
  var geolocator = Geolocator();
  final _formkey = GlobalKey<FormState>();
  late TextEditingController _petrol95Controller;
  late TextEditingController _petrol98Controller;
  late TextEditingController _petrolONController;
  late TextEditingController _petrolLPGController;
  FirestoreDB _db = new FirestoreDB();

  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _petrol95Controller = TextEditingController();
    _petrol98Controller = TextEditingController();
    _petrolONController = TextEditingController();
    _petrolLPGController = TextEditingController();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/petrol-marker.png')
        .then((value) => myIcon = value);
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), 'assets/drop.png')
        .then((value) => dropIcon = value);
  }

  @override
  void dispose() {
    _petrol95Controller.dispose();
    _petrol98Controller.dispose();
    _petrolONController.dispose();
    _petrolLPGController.dispose();
    super.dispose();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    _currentPosition = position;

    var latlng = LatLng(position.latitude, position.longitude);

    var cameraPosition = CameraPosition(target: latlng, zoom: 12);

    await controller
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    final petrolStations = await locations.getPetrolStations(
        position.latitude, position.longitude);

    setState(() {
      _markers.clear();
      for (final station in petrolStations.stations) {
        print(station.name);
        final marker = Marker(
          onTap: () {
            _showDialog(station);
          },
          icon: myIcon,
          markerId: MarkerId(station.name),
          position: LatLng(
              station.geometry.location.lat, station.geometry.location.lng),
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
    final loginProvider = Provider.of<AuthServices>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Najbliższe stacje benzynowe'),
          actions: [
            IconButton(
                onPressed: () async => await loginProvider.logout(),
                icon: Icon(Icons.exit_to_app)),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment(0.0, 2),
                    colors: <Color>[Colors.green, Colors.lightGreen])),
          ),
        ),
        body: GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: const LatLng(0, 0),
            zoom: 12,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }

  void _showDialog(Station station) async {
    await _db.getStation(station);
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
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.lightGreen,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Title(
                                  color: Colors.black,
                                  child: Text(
                                    station.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            station.vicinity,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 15),
                          RatingBarIndicator(
                            rating: station.rating,
                            itemCount: 5,
                            direction: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                Icon(Icons.star, color: Colors.amber),
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('assets/petrol95.png'),
                                ),
                                SizedBox(width: 15),
                                Flexible(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _petrol95Controller,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.amberAccent,
                                      hintText: station.price95,
                                      prefixIcon: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child:
                                              Image.asset('assets/drop.png')),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            color: Colors.lightGreen,
                                            width: 3.0),
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
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('assets/petrol98.png'),
                                ),
                                SizedBox(width: 15),
                                Flexible(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _petrol98Controller,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.amberAccent,
                                      hintText: station.price98,
                                      prefixIcon: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child:
                                              Image.asset('assets/drop.png')),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            color: Colors.lightGreen,
                                            width: 3.0),
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
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('assets/petrolON.png'),
                                ),
                                SizedBox(width: 15),
                                Flexible(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _petrolONController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.amberAccent,
                                      hintText: station.priceON,
                                      prefixIcon: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child:
                                              Image.asset('assets/drop.png')),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            color: Colors.lightGreen,
                                            width: 3.0),
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
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('assets/petrolLPG.png'),
                                ),
                                SizedBox(width: 15),
                                Flexible(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _petrolLPGController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.amberAccent,
                                      hintText: station.priceLPG,
                                      prefixIcon: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child:
                                              Image.asset('assets/drop.png')),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            color: Colors.lightGreen,
                                            width: 3.0),
                                      ),
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Center(
                            child: MaterialButton(
                              onPressed: () {
                                var dataChanged = false;
                                if (_petrol95Controller.text != '') {
                                  station.price95 = _petrol95Controller.text;
                                  _petrol95Controller.text = '';
                                  dataChanged = true;
                                }
                                if (_petrol98Controller.text != '') {
                                  station.price98 = _petrol98Controller.text;
                                  _petrol98Controller.text = '';
                                  dataChanged = true;
                                }
                                if (_petrolONController.text != '') {
                                  station.priceON = _petrolONController.text;
                                  _petrolONController.text = '';
                                  dataChanged = true;
                                }
                                if (_petrolLPGController.text != '') {
                                  station.priceLPG = _petrolLPGController.text;
                                  _petrolLPGController.text = '';
                                  dataChanged = true;
                                }
                                if (dataChanged) {
                                  _db.addStation(station);
                                }
                                Navigator.pop(context);
                              },
                              height: 50,
                              color: Colors.lightGreen,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                'Zapisz',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
