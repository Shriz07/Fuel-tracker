import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fuel_tracker/l10n/app_localizations.dart';
import 'package:fuel_tracker/main.dart';

class CarNotifications extends StatefulWidget {
  @override
  _CarNotificationsState createState() => _CarNotificationsState();
}

class _CarNotificationsState extends State<CarNotifications> {
  DateTime insuranceDate = DateTime.now();
  DateTime technicalInspectionDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, String dateType) async {
    final picked = await showDatePicker(context: context, initialDate: insuranceDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != insuranceDate) {
      setState(() {
        if (dateType == 'insurance') {
          insuranceDate = picked;
        } else if (dateType == 'technical') {
          technicalInspectionDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(t!.notificationsTitle),
        ),
        body: Container(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Center(
                      child: Tooltip(
                        showDuration: Duration(seconds: 5),
                        textStyle: TextStyle(fontSize: 15, color: Theme.of(context).errorColor),
                        padding: const EdgeInsets.all(8.0),
                        message: t.notificationsHint,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                                begin: Alignment(0.0, 2), end: Alignment.topCenter, colors: <Color>[Theme.of(context).secondaryHeaderColor, Theme.of(context).primaryColor])),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              t.notificationsHeader,
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.info),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    notificationDate(context, t.notification1Title, insuranceDate, 'insurance'),
                    SizedBox(height: 15),
                    applyButton(t.notification1Title, t.notification1Message),
                    SizedBox(height: 30),
                    notificationDate(context, t.notification2Title, technicalInspectionDate, 'technical'),
                    SizedBox(height: 15),
                    applyButton(t.notification2Title, t.notification2Message),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget notificationDate(BuildContext context, String notificationName, DateTime notificationDate, String dataType) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(notificationName, style: TextStyle(fontSize: 17)),
          Spacer(),
          GestureDetector(
            onTap: () {
              _selectDate(context, dataType);
            },
            child: Container(
              width: 150,
              decoration: BoxDecoration(
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
                    '${notificationDate.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget applyButton(String notificationTitle, String notificationMessage) {
    var t = AppLocalizations.of(context);
    return Center(
      child: MaterialButton(
        onPressed: () async {
          if (notificationMessage == t!.notification1Message) {
            scheduleAlarm(insuranceDate, notificationTitle, notificationMessage);
          } else if (notificationMessage == t.notification2Message) {
            scheduleAlarm(technicalInspectionDate, notificationTitle, notificationMessage);
          }
        },
        height: 50,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          t!.notificationsApplyButton,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void scheduleAlarm(DateTime date, String notificationTitle, String notificationMessage) async {
    date = date.subtract(Duration(days: 5));
    date = date.add(Duration(hours: 9));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
    );
    var iOSPlatformChannelSpecificts = IOSNotificationDetails(presentAlert: true, presentBadge: true, presentSound: false);
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecificts);
    await flutterLocalNotificationsPlugin.schedule(0, notificationTitle, notificationMessage, date, platformChannelSpecifics);
  }
}
