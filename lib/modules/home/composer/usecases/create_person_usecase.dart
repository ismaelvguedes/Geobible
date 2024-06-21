import 'package:geobible/modules/home/composer/repository/person_repository.dart';
import 'package:geobible/modules/home/data/model/person.dart';

class CreatePersonUsecase {
  PersonRepository repository;
  CreatePersonUsecase({
    required this.repository,
  });

  void execute(Person person) {
    return repository.createPerson(person);
  }
}