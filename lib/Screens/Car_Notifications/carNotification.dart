class CarNotification {
  CarNotification({
    required this.title,
    required this.description,
    required this.date,
    required this.userID,
  });

  factory CarNotification.fromJson(Map<String, dynamic> json) {
    return CarNotification(title: json['title'], description: json['description'], date: json['date'], userID: json['userID']);
  }

  CarNotification.fromMap(Map snapshot)
      : title = snapshot['title'],
        description = snapshot['description'],
        date = snapshot['date'].toDate(),
        userID = snapshot['userID'];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'userID': userID,
    };
  }

  String title;
  String description;
  DateTime date;
  String userID;
}
