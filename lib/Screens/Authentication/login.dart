import 'package:flutter/material.dart';
import 'package:fuel_tracker/screens/authentication/reset.dart';
import 'package:fuel_tracker/widgets/authentication_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fuel_tracker/services/authentication_services/auth_services.dart';
import 'package:fuel_tracker/services/dark_mode/dark_theme_preference.dart';
import 'package:fuel_tracker/services/dark_mode/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final VoidCallback? toggleScreen;

  const Login({Key? key, this.toggleScreen}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
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
                    authenticationFormField(_emailController, (val) => val!.isNotEmpty ? null : t!.loginEmailValidatorMessage, t!.loginEmailHint, Icon(Icons.mail), false),
                    SizedBox(height: 30),
                    authenticationFormField(_passwordController, (val) => val!.length < 6 ? t.loginPasswordValidatorMessage : null, t.loginPasswordHint, Icon(Icons.vpn_key), true),
                    SizedBox(height: 30),
                    Center(
                      child: MaterialButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await loginProvider.login(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                          }
                        },
                        height: 70,
                        minWidth: loginProvider.isLoading ? null : double.infinity,
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: loginProvider.isLoading
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              )
                            : Text(
                                t.loginButtonApply,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 20),
                    textLink(t.loginNoAccountMessage, t.loginNoAccountButton, () => widget.toggleScreen!()),
                    SizedBox(height: 20),
                    textLink(t.loginPasswordResetMessage, t.loginPasswordResetButton, () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetScreen()))),
                    SizedBox(height: 20),
                    if (loginProvider.errorMessage != '')
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: Theme.of(context).indicatorColor,
                        child: ListTile(
                          title: Text(
                            loginProvider.errorMessage,
                            style: TextStyle(color: Theme.of(context).errorColor),
                          ),
                          leading: Icon(Icons.error),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => loginProvider.setMessage(''),
                          ),
                        ),
                      )
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
