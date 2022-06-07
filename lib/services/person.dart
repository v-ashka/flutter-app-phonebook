import 'dart:convert';
import 'package:http/http.dart';


int personAmount=20;
int itemList = 0;
class Person {

  String firstname;
  String lastname;
  String phoneNumber;
  String city;
  String imageUrl;

  Person({required this.firstname, required this.lastname, required this.phoneNumber, required this.imageUrl, required this.city});

  Person.fromJson(Map<String, dynamic> json):
      firstname = json['name']['first'],
      lastname = json['name']['last'],
      phoneNumber = json['phone'],
      imageUrl = json['picture']['medium'],
      city = json['location']['city'];

  Person.fromDatabase(Map<String, dynamic> json):
        firstname = json['firstname'],
        lastname = json['lastname'],
        phoneNumber = json['phoneNumber'],
        imageUrl = json['imageUrl'],
        city = json['city'];

  Map<String, dynamic> toJson() => {
      'firstname': firstname,
      'lastname': lastname,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'city': city
  };

  Person.fromMap(Map<String, dynamic> map):
    firstname = map['firstname'],
    lastname = map['lastname'],
    phoneNumber = map['phoneNumber'],
    imageUrl = map['imageUrl'],
    city = map['city'];


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'firstname': firstname,
      'lastname': lastname,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'city': city,
    };
    return map;
  }



  @override
  String toString() {
    return "{firstname: $firstname, lastname: $lastname, phoneNumber: $phoneNumber, imageUrl: $imageUrl, city: $city}";
  }
}

class PersonNetworkService{
  Future<List<Person>> fetchPersons(int amount) async {
    String authority = 'randomuser.me';
    Response response = await get(Uri.http(authority, '/api/', {'results': '$amount', 'inc': 'name,phone,picture,location'}));
      if(response.statusCode == 200){
        Map peopleData = jsonDecode(response.body);
        List<dynamic> peoples = peopleData['results'];
        print(peoples);
        return peoples.map((json) => Person.fromJson(json)).toList();
      } else {
        throw Exception("Something gone wrong, ${response.statusCode}");
      }
  }
}
