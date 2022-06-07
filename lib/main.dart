import 'package:flutter/material.dart';
import 'pages/loading.dart';
import 'pages/home.dart';
import 'package:phone_book/pages/edituser.dart';
// import 'package:phone_book/constants.dart';
import 'package:phone_book/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/editUser': (context) => EditUser(),
      },
      title: 'Phone Book',
      theme: ThemeData(
        scaffoldBackgroundColor: primaryBgColor,
        colorScheme: ThemeData().colorScheme.copyWith(primary: pColor),
        appBarTheme: AppBarTheme(
          color: pColor
        ),
        textTheme: Theme.of(context).textTheme.apply(bodyColor: pColor),
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
    );
  }
}
