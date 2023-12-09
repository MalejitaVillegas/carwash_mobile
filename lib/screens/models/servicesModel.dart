import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesModel {
  final String title;
  final String description;
  final String photo;
  final price;

  ServicesModel(
      {required this.title,
      required this.description,
      required this.photo,
      required this.price});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'photo': photo,
      'price': price
    };
  }

  ServicesModel.fromMap(Map<String, dynamic> addressMap)
      : title = addressMap["title"],
        description = addressMap["description"],
        photo = addressMap["photo"],
        price = addressMap["price"];

  ServicesModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : title = doc.data()!["title"],
        description = doc.data()!["description"],
        photo = doc.data()!["photo"],
        price = doc.data()!["price"];
}
