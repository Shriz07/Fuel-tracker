import 'package:flutter/material.dart';
import 'package:fuel_tracker/Widgets/app_bar.dart';
import 'package:fuel_tracker/Widgets/authentication_widgets.dart';
import 'package:fuel_tracker/l10n/app_localizations.dart';
import 'package:fuel_tracker/services/dark_mode/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: MyAppBar(context, t!.aboutTitle, false),
      body: Container(
        decoration: BoxDecoration(
          image: CustomDecorationImage(themeChange.darkTheme),
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
                  CustomTextBox(t.aboutVersion, 'v0.9'),
                  SizedBox(height: 20),
                  InkWell(
                    child: CustomTextBox(t.aboutAuthor, 'Adam Mąkiewicz'),
                    onTap: () => launch('https://github.com/Shriz07'),
                  ),
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
