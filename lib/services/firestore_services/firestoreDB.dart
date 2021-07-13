import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fuel_tracker/Screens/Petrol_map/locations.dart';

class FirestoreDB extends ChangeNotifier {
  final CollectionReference _stationsCollectionReference =
      FirebaseFirestore.instance.collection('stations');

  Future addStation(Station station) async {
    try {
      return await _stationsCollectionReference
          .doc(station.place_id)
          .set(station.toMap());
    } catch (e) {
      print(e.toString());
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future getStation(Station station) async {
    try {
      await _stationsCollectionReference
          .doc(station.place_id)
          .get()
          .then((snapshot) => station.setData(snapshot));
    } catch (e) {
      print(e.toString());
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }
}
