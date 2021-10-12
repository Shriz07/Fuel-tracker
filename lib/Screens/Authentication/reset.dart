import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuel_tracker/Widgets/popup_dialog.dart';
import 'package:fuel_tracker/services/authentication_services/auth_services.dart';
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
    bool _isError = false;

    return Scaffold(
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
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Center(
                        child: Image(
                      image: AssetImage('assets/logo.png'),
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
                              'Zresetuj hasło',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      validator: (val) => val!.isNotEmpty ? null : 'Podaj email',
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.yellow, fontSize: 15),
                        filled: true,
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.mail),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: MaterialButton(
                        onPressed: () async {
                          try {
                            await auth.sendPasswordResetEmail(email: _emailController.text.trim());
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) => PopupDialog(
                                title: 'Powiadomienie',
                                message: 'Na twoją skrzynkę mailową został wysłany link do zmiany hasła.',
                                close: 'Zamknij',
                              ),
                            );
                            Navigator.of(context).pop();
                          } on FirebaseAuthException catch (e) {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) => PopupDialog(
                                title: 'Uwaga',
                                message: 'Wystąpił błąd. Sprawdź czy podałeś poprawny email.',
                                close: 'Zamknij',
                              ),
                            );
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
                          'Resetuj',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    /*if (_isError == true)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: Theme.of(context).indicatorColor,
                        child: ListTile(
                          title: Text(
                            'Błąd',
                            style: TextStyle(color: Theme.of(context).errorColor),
                          ),
                          leading: Icon(Icons.error),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => _isError = false,
                          ),
                        ),
                      )*/
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
