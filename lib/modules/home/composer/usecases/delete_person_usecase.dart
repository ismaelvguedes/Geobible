import 'package:geobible/modules/home/composer/repository/person_repository.dart';
import 'package:geobible/modules/home/data/model/person.dart';

class DeletePersonUsecase {
  PersonRepository repository;
  DeletePersonUsecase({
    required this.repository,
  });

  void execute(Person person) {
    return repository.deletePerson(person);
  }
}