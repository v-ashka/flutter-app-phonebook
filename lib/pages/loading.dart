import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:phone_book/constants.dart';
import 'package:phone_book/services/db.dart';
import '../services/user_list.dart';
import '../services/person.dart';
import 'dart:io';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List dataTemp = [];
  void setupData() async{
    // Users instance = Users();
    // await instance.getUsers();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Jest połączenie z siecią');
        PersonNetworkService personService = PersonNetworkService();
        dataTemp = await personService.fetchPersons(personAmount);
        await DbProvider.db.getAllUsers();
      }
    } on SocketException catch (_) {
      print('Brak połaczenia z siecią');
    }
    // print(dataTemp[0].imageUrl);
    // dataTemp =await personService.fetchPersons(20);
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'userList': dataTemp,
    });
  }

  @override
  void initState() {
    super.initState();
    setupData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pColor,
      body: Center(
        child: SpinKitDancingSquare(
          color: Colors.white,
          size: 150,
        ),
      ),
    );
  }
}
