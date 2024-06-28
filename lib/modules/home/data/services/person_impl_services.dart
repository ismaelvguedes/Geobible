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
  Future<void> createPerson(Map<String, dynamic> data) async{
    await store.collection('persons').add(data);
  }

  @override
  Future<void> updatePerson(String ref, Map<String, dynamic> data) async{
    await store.collection('persons').doc(ref).update(data);
  }

  @override
  Future<void> deletePerson(String ref) async{
    await store.collection('persons').doc(ref).delete();
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getPersonByRef(String ref) async {
    return await store.doc(ref).get();
  }
}
