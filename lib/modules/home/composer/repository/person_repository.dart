import 'package:geobible/modules/home/data/model/person.dart';

abstract class PersonRepository {
  Stream<List<Person>> streamPersons();
  void createPerson(Person person);
  void updatePerson(Person person);
  void deletePerson(Person person);
  Future<Person> getPersonByRef(String ref);
}