import 'package:geobible/modules/home/data/model/person.dart';

abstract class PersonRepository {
  Stream<List<Person>> streamPersons();
  Future<void> createPerson(Person person);
  Future<void> updatePerson(Person person);
  Future<void> deletePerson(Person person);
  Future<Person> getPersonByRef(String ref);
}