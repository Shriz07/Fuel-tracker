import 'package:flutter/material.dart';
import 'package:fuel_tracker/services/authentication_services/auth_services.dart';
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
                    TextFormField(
                      controller: _emailController,
                      validator: (val) => val!.isNotEmpty ? null : 'Podaj adres Email',
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.yellow, fontSize: 15),
                        filled: true,
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.mail),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordController,
                      validator: (val) => val!.length < 6 ? 'Podaj przynajmniej 6 znaków' : null,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.yellow, fontSize: 15),
                        filled: true,
                        hintText: 'Hasło',
                        prefixIcon: Icon(Icons.vpn_key),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: MaterialButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            print(_emailController.text);
                            print(_passwordController.text);
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
                                'Zaloguj',
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
                            'Nie posiadasz konta?',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () => widget.toggleScreen!(),
                            child: Text(
                              'Stwórz konto',
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    if (loginProvider.errorMessage != '')
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: Colors.amberAccent,
                        child: ListTile(
                          title: Text(loginProvider.errorMessage),
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
