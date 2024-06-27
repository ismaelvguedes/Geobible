import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  String? id;
  String name;
  String description;
  String imageURL;
  String sex;
  String ref;
  String father;
  String mother;

  Person({
    this.id,
    required this.name,
    required this.description,
    required this.imageURL,
    required this.sex,
    required this.ref,
    required this.father,
    required this.mother,
  });

  factory Person.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = doc.data() ?? {};
    String documentReferenceToString(dynamic reference) {
      if (reference is DocumentReference) {
        return reference.path;
      } else if (reference is String) {
        return reference;
      }
      return '';
    }

    return Person(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageURL: data['imageURL'] ?? '',
      sex: data['sex'] ?? '',
      ref: data['ref'] ?? '',
      father: documentReferenceToString(data['father']),
      mother: documentReferenceToString(data['mother']),
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
      'father': person.father,
      'mother': person.mother,
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
      'father': father,
      'mother': mother,
    };
  }
}