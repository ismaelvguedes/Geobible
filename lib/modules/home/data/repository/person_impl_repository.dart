import 'package:geobible/modules/home/composer/repository/person_repository.dart';
import 'package:geobible/modules/home/composer/services/person_services.dart';
import 'package:geobible/modules/home/data/model/person.dart';

class PersonImplRepository implements PersonRepository {
  final PersonServices services;

  PersonImplRepository({required this.services});

  @override
  Stream<List<Person>> streamPersons() {
    return services.streamPersons();
  }

  @override
  void createPerson(Person person) {
    services.createPerson(person.toMap());
  }

  @override
  void updatePerson(Person person) {
    services.updatePerson(person.id, person.toMap());
  }

  @override
  void deletePerson(Person person) {
    services.deletePerson(person.id);
  }
}