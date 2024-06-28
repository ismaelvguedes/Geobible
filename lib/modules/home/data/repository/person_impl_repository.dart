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
  Future<void> createPerson(Person person) async{
    final result = person.toMap();
    result.remove("id");
    if (result["father"].isNotEmpty) {
      result["father"] = "persons/${result["father"]}";
    }
    if (result["mother"].isNotEmpty) {
      result["mother"] = "persons/${result["mother"]}";
    }
    await services.createPerson(result);
  }

  @override
  Future<void> updatePerson(Person person) async{
    if (person.id != null) {
      await services.updatePerson(person.id!, person.toMap());
    }
  }

  @override
  Future<void> deletePerson(Person person) async{
    if (person.id != null) {
      await services.deletePerson(person.id!);
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
