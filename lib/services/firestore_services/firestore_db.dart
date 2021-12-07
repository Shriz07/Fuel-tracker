import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fuel_tracker/Models/CarNotification.dart';
import 'package:fuel_tracker/Models/Locations.dart';
import 'package:fuel_tracker/Models/UserStats.dart';

class FirestoreDB extends ChangeNotifier {
  final CollectionReference _stationsCollectionReference = FirebaseFirestore.instance.collection('stations');
  final CollectionReference _usersCollectionReference = FirebaseFirestore.instance.collection('users');

  Future addStation(Station station) async {
    try {
      return await _stationsCollectionReference.doc(station.place_id).set(station.toMap());
    } catch (e) {
      print(e.toString());
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future getStation(Station station) async {
    try {
      await _stationsCollectionReference.doc(station.place_id).get().then((snapshot) => station.setData(snapshot));
      return true;
    } catch (e) {
      if (e is StateError) return true;
      return false;
    }
  }

  Future addNotification(CarNotification notification) async {
    try {
      return await _usersCollectionReference.doc('notifications').collection(notification.userID).doc(notification.title).set(notification.toMap());
    } catch (e) {
      print(e.toString());
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future getNotifications(String userID) async {
    var notif = await _usersCollectionReference.doc('notifications').collection(userID).get();
    try {
      return notif.docs.map((snapshot) => CarNotification.fromMap(snapshot.data())).toList();
    } catch (e) {
      return false;
    }
  }

  Future addUserStats(String userID) async {
    try {
      var userStats = UserStats(updates: 1, lastUpdate: Timestamp.now(), userID: userID);
      return await _usersCollectionReference.doc('stats').collection(userStats.userID).doc('userstats').set(userStats.toMap());
    } catch (e) {
      print(e.toString());
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future incrementUserStats(String userID) async {
    try {
      List<UserStats> userStats = await getUserStats(userID);
      userStats.first.incrementUpdates();
      await _usersCollectionReference.doc('stats').collection(userID).doc('userstats').update(userStats.first.toMap());
    } catch (e) {
      await addUserStats(userID);
      print(e.toString());
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future getUserStats(String userID) async {
    var stats = await _usersCollectionReference.doc('stats').collection(userID).get();
    try {
      return stats.docs.map((snapshot) => UserStats.fromMap(snapshot.data())).toList();
    } catch (e) {
      return false;
    }
  }
}
