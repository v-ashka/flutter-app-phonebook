import 'package:flutter/material.dart';
import 'package:phone_book/constants.dart';
import 'package:phone_book/pages/components/header.dart';
import 'package:phone_book/services/person.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.data, required this.showOnlineData}) : super(key: key);

  final Map data;
  final bool showOnlineData;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  void modifyUser(index) async {
    Navigator.pushNamed(context, '/editUser', arguments: {
      "id": index+1,
      "firstname": widget.data["userList"][index].firstname,
      "lastname": widget.data["userList"][index].lastname,
      "phoneNumber": widget.data["userList"][index].phoneNumber,
      "imageUrl": widget.data["userList"][index].imageUrl,
      "city": widget.data['userList'][index].city,
    });
  }


  @override
  Widget build(BuildContext context) {
  Size? size = MediaQuery.of(context).size;
  // print(widget.data['userList'][0]['imageUrl']);
  print("TYPE DATA ${widget.data.runtimeType}");
  // print('TEST AFTER SENT REQUEST: ${widget.data['userList'][0]['imageUrl']}');
  // print(widget.data['userList'][0]['location']['city']);
  print("ITEM LIST: ${widget.data['userList'].length}");
    return Column(
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
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: ListView.builder(
                  itemCount: itemList == 0 || itemList > widget.data['userList'].length ? (widget.data['userList'].length):(itemList),
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: (){
                          widget.showOnlineData ? (null):(modifyUser(index));
                        },
                        child: Card(
                          child: Container(
                            height: 75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 75,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                          ),
                                            child: Image.network(widget.data['userList'][index].imageUrl))
                                    ),
                                    Spacer(flex: 1),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.data['userList'][index].firstname,),
                                        Text(widget.data['userList'][index].lastname,  style: TextStyle(fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Spacer(flex: 4),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0 , 15 ,0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(widget.data['userList'][index].phoneNumber),
                                          Text(widget.data['userList'][index].city),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ),
      ],

      // child: Column(
      //   children: [
      //     // Header(size: size),
      //     Text("${widget.data['userList'].length}", style: TextStyle(color: Colors.black),),
      //   ],
      // ),
    );
  }
}
