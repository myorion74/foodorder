import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Future<void> _login() async {
    var host = 'ysth.intranet';
    var login = 'yt600923'; //loginController.text;
    String password = 'Vv44444$'; //passController.text;
    var port = 389;

    var connection = new d(
        host: host, ssl: false, port: port, bindDN: login, password: password);

    try {
      await connection.open();
      await connection.bind();
      print('Bind OK');
    } catch (e, stacktrace) {
      print('********* Exception: $e, Stacktrace: $stacktrace');
    } finally {
      print('Closing');
      await connection.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _login,
          child: Text('Login with Active Directory'),
        ),
      ),
    );
  }
}
