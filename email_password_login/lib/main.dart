import 'package:email_password_login/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCe26vO3l0Wm0Z6wgxh8xf4lb5OSC2ZqdM",
      appId: "111740973824371771608",
      databaseURL:
          "https://iot-for-disabled-people-default-rtdb.firebaseio.com/",
      messagingSenderId: "XXX",
      projectId: "iot-for-disabled-people",
    ),
  );
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: const <String, WidgetBuilder>{},
      title: 'Email and Password Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
