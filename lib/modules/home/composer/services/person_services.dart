import 'package:geobible/modules/home/data/model/person.dart';

abstract class PersonServices {
  Stream<List<Person>> streamPersons();
  void createPerson(Map<String, dynamic> data);
  void updatePerson(String ref, Map<String, dynamic> data);
  void deletePerson(String ref);
}