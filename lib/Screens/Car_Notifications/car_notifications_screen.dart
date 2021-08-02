import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fuel_tracker/Screens/Car_Notifications/car_notification.dart';
import 'package:fuel_tracker/Widgets/popup_dialog.dart';
import 'package:fuel_tracker/l10n/app_localizations.dart';
import 'package:fuel_tracker/main.dart';
import 'package:fuel_tracker/services/firestore_services/firestore_db.dart';

class CarNotifications extends StatefulWidget {
  @override
  _CarNotificationsState createState() => _CarNotificationsState();
}

class _CarNotificationsState extends State<CarNotifications> {
  final _db = FirestoreDB();
  final auth = FirebaseAuth.instance;
  late List<CarNotification> carNotifications;
  bool loaded = false;
  bool statusWasChanged = false;

  Future<void> _selectDate(BuildContext context, CarNotification notification) async {
    final picked = await showDatePicker(context: context, initialDate: notification.date, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != notification.date) {
      setState(() {
        notification.date = picked;
        if (notification.isSet == false) {
          notification.isSet = true;
          statusWasChanged = true;
        }
      });
    }
  }

  Future<List> getNotifications() async {
    if (!loaded) {
      var t = AppLocalizations.of(context);
      carNotifications = await _db.getNotifications(auth.currentUser!.uid);
      if (carNotifications.isEmpty) {
        var insuranceNotification =
            CarNotification(id: 0, title: t!.notification1Title, description: t.notification1Message, date: DateTime.now(), userID: auth.currentUser!.uid, isSet: false);
        carNotifications.add(insuranceNotification);
        var technicalNotification =
            CarNotification(id: 1, title: t.notification2Title, description: t.notification2Message, date: DateTime.now(), userID: auth.currentUser!.uid, isSet: false);
        carNotifications.add(technicalNotification);
      }
      loaded = true;
    }
    return carNotifications;
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(t!.notificationsTitle),
        ),
        body: FutureBuilder<List>(
          future: getNotifications(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.data != null) {
              return Container(
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
                              textStyle: TextStyle(fontSize: 15, color: Colors.white),
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(8.0),
                              message: t.notificationsHint,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Theme.of(context).primaryColor,
                              ),
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
                          notificationDate(context),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Widget notificationDate(BuildContext context) {
    var t = AppLocalizations.of(context);
    List<Widget> notificationWidgets = [];

    for (final notification in carNotifications) {
      notificationWidgets.add(
        SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(notification.title, style: TextStyle(fontSize: 17)),
              Spacer(),
              GestureDetector(
                onTap: () {
                  _selectDate(context, notification);
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
                      child: notification.isSet
                          ? Text(
                              '${notification.date.toLocal()}'.split(' ')[0],
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          : Text(t!.dateSelectTitle), //Date select text
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    notification.isSet = false;
                    _db.addNotification(notification).then(
                          (value) => {
                            cancelNotification(notification.id),
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => PopupDialog(
                                title: t!.petrolMapWarningTitle,
                                message: t.notificationDeleteTitle1 + notification.title + t.notificationDeleteTitle2, //Message about notification deletation
                                close: t.petrolMapWarningClose,
                              ),
                            ),
                          },
                        );
                  });
                },
                icon: Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      );
      notificationWidgets.add(SizedBox(height: 15));
      notificationWidgets.add(applyButton(notification));
      notificationWidgets.add(SizedBox(height: 30));
    }

    return Column(children: notificationWidgets);
  }

  Widget applyButton(CarNotification notification) {
    var t = AppLocalizations.of(context);
    return Center(
      child: MaterialButton(
        onPressed: () async {
          if (notification.isSet == false || statusWasChanged == true) {
            setState(() {
              statusWasChanged = false;
              notification.isSet = true;
              scheduleAlarm(notification.date, notification.title, notification.description, notification.id);
              for (final n in carNotifications) {
                _db.addNotification(n);
              }
              showDialog(
                context: context,
                builder: (BuildContext context) => PopupDialog(
                  title: t!.petrolMapWarningTitle,
                  message: t.notificationAddTitle1 + notification.title + t.notificationAddTitle2, //Message about notification addition
                  close: t.petrolMapWarningClose,
                ),
              );
            });
          } else {
            await showDialog(
              context: context,
              builder: (BuildContext context) => PopupDialog(
                title: t!.petrolMapWarningTitle,
                message: t.notificationAlreadySetMessage, //Message informing that notification was already set
                close: t.petrolMapWarningClose,
              ),
            );
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

  void scheduleAlarm(DateTime date, String notificationTitle, String notificationMessage, int id) async {
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
    await flutterLocalNotificationsPlugin.schedule(id, notificationTitle, notificationMessage, date, platformChannelSpecifics);
  }

  void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
