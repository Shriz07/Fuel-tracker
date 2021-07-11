import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'locations.dart' as locations;

class PetrolMap extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PetrolMap> {
  Position? _currentPosition;
  late BitmapDescriptor myIcon;
  var geolocator = Geolocator();

  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/petrol-marker.png')
        .then((value) => myIcon = value);
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
      for (final station in petrolStations.results) {
        print(station.name);
        final marker = Marker(
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Najbliższe stacje benzynowe'),
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
}
