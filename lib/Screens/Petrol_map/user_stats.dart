import 'package:cloud_firestore/cloud_firestore.dart';

class UserStats {
  UserStats({
    required this.updates,
    required this.lastUpdate,
    required this.userID,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(updates: json['updates'], lastUpdate: json['lastUpdate'], userID: json['userID']);
  }

  UserStats.fromMap(Map snapshot)
      : updates = snapshot['updates'],
        lastUpdate = snapshot['lastUpdate'],
        userID = snapshot['userID'];

  Map<String, dynamic> toMap() {
    return {
      'updates': updates,
      'lastUpdate': lastUpdate,
      'userID': userID,
    };
  }

  int updates;
  Timestamp lastUpdate;
  String userID;

  void incrementUpdates() {
    updates++;
    lastUpdate = Timestamp.now();
  }
}
