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
    final result = person.toMap();
    result.remove("id");
    services.createPerson(result);
  }

  @override
  void updatePerson(Person person) {
    if (person.id != null) {
      services.updatePerson(person.id!, person.toMap());
    }
  }

  @override
  void deletePerson(Person person) {
    if (person.id != null) {
      services.deletePerson(person.id!);
    }
  }

  @override
  Future<Person> getPersonByRef(String ref) async {
    if (ref.isNotEmpty) {
      try {
        return Person.fromFirestore(await services.getPersonByRef(ref), null);
      } catch (e) {
        return Future.error("Error na refêrencia de person: $e");
      }
    } else {
      return Future.error("Refêrencia não existe");
    }
  }
}
