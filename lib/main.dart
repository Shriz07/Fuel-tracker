import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Position? _currentPosition;
  var geolocator = Geolocator();

  final Map<String, Marker> _markers = {};

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
          title: const Text('Nearby petrol stations'),
          backgroundColor: Colors.green[700],
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
