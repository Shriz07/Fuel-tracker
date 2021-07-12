import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthServices with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future register(String email, String password) async {
    setLoading(true);
    try {
      var authResult = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);
      setMessage('Brak połaczenia z internetem.');
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      if (e.code == 'email-already-in-use') {
        setMessage('Konto z podanym adresem Email już istnieje');
      } else {
        setMessage('Wystąpił błąd, sprawdź wprowadzone dane');
      }
    } on Exception catch (e) {
      setLoading(false);
      setMessage('Wystąpił błąd, sprawdź wprowadzone dane');
    }
    notifyListeners();
  }

  Future login(String email, String password) async {
    setLoading(true);
    try {
      var authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);
      setMessage('Brak połaczenia z internetem.');
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      print(e.code);
      if (e.code == 'invalid_email') {
        setMessage('Niepoprawny adres Email');
      } else if (e.code == 'wrong-password') {
        setMessage('Niepoprawne hasło');
      } else {
        setMessage('Wystąpił błąd, sprawdź wprowadzone dane');
      }
    } on Exception catch (e) {
      setLoading(false);
      setMessage('Wystąpił błąd, sprawdź wprowadzone dane');
    }
    notifyListeners();
  }

  Future logout() async {
    await firebaseAuth.signOut();
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  Stream<User?> get user =>
      firebaseAuth.authStateChanges().map((event) => event);
}
