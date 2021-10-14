import 'package:flutter/material.dart';
import 'package:fuel_tracker/l10n/app_localizations.dart';
import 'package:fuel_tracker/services/authentication_services/auth_services.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function toggleScreen;

  const Register({Key? key, required this.toggleScreen}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Register> {
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
                              t!.registerTitle,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    registerFormField(_emailController, (val) => val!.isNotEmpty ? null : t.registerEmailValidatorMessage, t.registerEmailHint, Icon(Icons.mail), false),
                    SizedBox(height: 30),
                    registerFormField(_passwordController, (val) => val!.length < 6 ? t.registerPasswordValidatorMessage : null, t.registerPasswordHint, Icon(Icons.vpn_key), true),
                    SizedBox(height: 30),
                    Center(
                      child: MaterialButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            await loginProvider.register(
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
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                t.registerButtonApply,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Material(
                      color: Colors.grey.withOpacity(0.8),
                      elevation: 10,
                      shadowColor: Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            t.registerAlreadyMessage,
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () => widget.toggleScreen(),
                            child: Text(
                              t.registerAlreadyButton,
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
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

  Widget registerFormField(TextEditingController controller, FormFieldValidator<String> validator, String hintText, Icon icon, bool obscure) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscure,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.yellow, fontSize: 15),
        filled: true,
        hintText: hintText,
        prefixIcon: icon,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
