import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/widgets/authentication_widgets.dart';
import 'package:fuel_tracker/widgets/popup_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fuel_tracker/services/dark_mode/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late TextEditingController _emailController;
  final _formkey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: CustomDecorationImage(themeChange.darkTheme),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Center(
                        child: Image(
                      image: AssetImage('assets/images/logo.png'),
                    )),
                    SizedBox(height: 40),
                    Material(
                      color: Colors.grey.withOpacity(0.8),
                      elevation: 10,
                      shadowColor: Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              t!.resetTitle,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    authenticationFormField(_emailController, (val) => val!.isNotEmpty ? null : t.resetEmailValidatorMessage, t.resetEmailHint, Icon(Icons.mail), false),
                    SizedBox(height: 30),
                    Center(
                      child: MaterialButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            try {
                              await auth.sendPasswordResetEmail(email: _emailController.text.trim());
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) => PopupDialog(
                                  title: t.resetCorrectPopupTitle,
                                  message: t.resetCorrectPopupMessage,
                                  close: t.resetCorrectPopupClose,
                                ),
                              );
                              Navigator.of(context).pop();
                            } on FirebaseAuthException catch (e) {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) => PopupDialog(
                                  title: t.resetErrorPopupTitle,
                                  message: t.resetErrorPopupMessage,
                                  close: t.resetErrorPopupClose,
                                ),
                              );
                            }
                          }
                        },
                        height: 70,
                        minWidth: double.infinity,
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          t.resetApplyButton,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
