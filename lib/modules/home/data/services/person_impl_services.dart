import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geobible/modules/home/composer/services/person_services.dart';
import 'package:geobible/modules/home/data/model/person.dart';

class PersonImplService implements PersonServices {
  final store = FirebaseFirestore.instance;
  @override
  Stream<List<Person>> streamPersons() {
    final snapshot = store
        .collection('persons')
        .withConverter(
          fromFirestore: Person.fromFirestore,
          toFirestore: Person.toFirestore,
        )
        .snapshots();

    return snapshot.map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  @override
  void createPerson(Map<String, dynamic> data) {
    store.collection('persons').add(data);
  }

  @override
  void updatePerson(String ref, Map<String, dynamic> data) {
    store.collection('persons').doc(ref).update(data);
  }

  @override
  void deletePerson(String ref) {
    store.collection('persons').doc(ref).delete();
  }
}