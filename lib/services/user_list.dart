import 'dart:convert';
import 'package:http/http.dart';

class Users{
  List? users;

  Future<void> getUsers() async{
    try{
      String authority = 'randomuser.me';
      Response response = await get(Uri.http(authority, '/api/', {'results': '20', 'inc': 'name,phone,picture,location'}));
      Map data = jsonDecode(response.body);
      // print(data['results']);
      users = data['results'];
    }
    catch(e){
      print('Wystapil problem z ładowaniem danych: ${e}');
    }
}

}