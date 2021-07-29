class CarNotification {
  CarNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.userID,
    required this.isSet,
  });

  factory CarNotification.fromJson(Map<String, dynamic> json) {
    return CarNotification(id: json['id'], title: json['title'], description: json['description'], date: json['date'], userID: json['userID'], isSet: json['isSet']);
  }

  CarNotification.fromMap(Map snapshot)
      : id = snapshot['id'],
        title = snapshot['title'],
        description = snapshot['description'],
        date = snapshot['date'].toDate(),
        userID = snapshot['userID'],
        isSet = snapshot['isSet'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'userID': userID,
      'isSet': isSet,
    };
  }

  int id;
  String title;
  String description;
  DateTime date;
  String userID;
  bool isSet;
}
