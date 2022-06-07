import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_book/constants.dart';
import 'package:phone_book/pages/components/header.dart';
import 'package:phone_book/services/db.dart';
import 'package:phone_book/services/person.dart';
import 'package:phone_book/pages/loading.dart';

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final __key = GlobalKey<FormState>();
  Map data = {};

  void editUser() async{
    var updatedData = Person(
        firstname: data['firstname'],
        lastname: data['lastname'],
        phoneNumber: data['phoneNumber'],
        imageUrl: data['imageUrl'],
        city: data['city']
    );

    DbProvider.db.updateMobile(updatedData, data['id']);
    DbProvider.db.getAllUsers();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Loading()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map ;
    print('edit data: $data');
    return Scaffold(
        backgroundColor: pColor,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Header(size: size),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryBgColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Form(
                                key: __key,
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage('${data['imageUrl']}'),
                                                backgroundColor: pColor,
                                                radius: 50,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          child: Text("${data['firstname'].toString().toUpperCase()} ${data['lastname'].toString().toUpperCase()}", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2.0),),
                                        ),
                                        // SizedBox(height: 20),
                                      ],
                                    ),

                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              child: Text("NAME"),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              width: size.width/1.5,
                                              child: TextFormField(
                                                initialValue: data['firstname'],
                                                onSaved: (String? value){data['firstname'] = value;},
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              child: Text("SURNAME"),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              width: size.width/1.5,
                                              child: TextFormField(
                                                  initialValue: data['lastname'],
                                                onSaved: (String? value){data['lastname'] = value;},

                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              child: Text("PHONE NUMBER"),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              width: size.width/1.5,
                                              child: TextFormField(
                                                  initialValue: data['phoneNumber'],
                                                onSaved: (String? value){data['phoneNumber'] = value;},

                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              child: Text("CITY"),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              width: size.width/1.5,
                                              child: TextFormField(
                                                initialValue: data['city'],
                                                onSaved: (String? value){data['city'] = value;},
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0,0,0,20),
                                              child: Container(
                                                height: 50,
                                                width: size.width/1.5,
                                                child: ElevatedButton(
                                                  child: Text('Zaktualizuj', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200),),
                                                  onPressed: () async {
                                                    print('clicked edit button');
                                                    __key.currentState!.save();
                                                    editUser();
                                                    print('procedure...');
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(25)
                                                    ),
                                                    primary: pColor
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ]
          ),
        ),
    );
  }
}
