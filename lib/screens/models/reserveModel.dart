import 'package:cloud_firestore/cloud_firestore.dart';

class ReserveModel {
  final String name;
  final price;
  final String type;
  final date;
  final uid;

  ReserveModel(
      {required this.name,
      required this.price,
      required this.type,
      required this.date,
      required this.uid});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'type': type,
      'date': date,
      'uid': uid
    };
  }

  ReserveModel.fromMap(Map<String, dynamic> addressMap)
      : name = addressMap["name"],
        price = addressMap["price"],
        type = addressMap["type"],
        date = addressMap["date"],
        uid = addressMap["uid"];

  ReserveModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : name = doc.data()!["name"],
        price = doc.data()!["price"],
        type = doc.data()!["type"],
        date = doc.data()!["date"],
        uid = doc.data()!["uid"];
}
