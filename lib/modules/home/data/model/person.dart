import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  String id;
  String name;
  String description;
  String imageURL;
  String sex;
  String ref;

  Person({
    required this.id,
    required this.name,
    required this.description,
    required this.imageURL,
    required this.sex,
    required this.ref,
  });

  factory Person.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return Person(
      id: (doc.id),
      name: doc['name'],
      description: doc['description'],
      imageURL: doc['imageURL'],
      sex: doc['sex'],
      ref: doc['ref'],
    );
  }

  static Map<String, dynamic> toFirestore(
    Person person,
    SetOptions? options,
  ) {
    return {
      'id': person.id,
      'name': person.name,
      'description': person.description,
      'imageURL': person.imageURL,
      'sex': person.sex,
      'ref': person.ref,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageURL': imageURL,
      'sex': sex,
      'ref': ref,
    };
  }
}