import 'package:flutter/material.dart';
import 'package:flutter_project/view/screens/SignIn_screen.dart';
import 'package:flutter_project/view/screens/home_screen.dart';
import 'package:flutter_project/view/screens/wellcome_screen.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dynamic token = SessionManager().get('token');
  runApp(MyApp(home: token != '' ? Home(): SignIn()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required home});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Param Cebimde',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Wellcome()
    );
  }
}

