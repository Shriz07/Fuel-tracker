import 'package:flutter/material.dart';
import 'package:fuel_tracker/l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        title: Text(
          t!.aboutTitle,
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(begin: Alignment.topCenter, end: Alignment(0.0, 2), colors: <Color>[Theme.of(context).secondaryHeaderColor, Theme.of(context).primaryColor])),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Center(
                      child: Image(
                    image: AssetImage('assets/logo.png'),
                  )),
                  SizedBox(height: 40),
                  CustomTextBox(t.aboutVersion, 'v0.5'),
                  SizedBox(height: 20),
                  CustomTextBox(t.aboutAuthor, 'Adam Mąkiewicz'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextBox extends StatelessWidget {
  CustomTextBox(this.textLeft, this.textRight);

  final String textLeft;
  final String textRight;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.withOpacity(0.8),
      elevation: 10,
      shadowColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textLeft,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(width: 5),
            Text(
              textRight,
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
