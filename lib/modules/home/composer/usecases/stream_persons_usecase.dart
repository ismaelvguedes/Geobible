import 'package:geobible/modules/home/composer/repository/person_repository.dart';
import 'package:geobible/modules/home/data/model/person.dart';

class StreamPersonsUsecase {
  PersonRepository repository;
  StreamPersonsUsecase({
    required this.repository,
  });

  Stream<List<Person>> execute() {
    return repository.streamPersons();
  }
}