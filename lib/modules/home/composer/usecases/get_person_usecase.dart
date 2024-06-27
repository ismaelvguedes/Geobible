import 'package:geobible/modules/home/composer/repository/person_repository.dart';
import 'package:geobible/modules/home/data/model/person.dart';

class GetPersonUsecase {
  PersonRepository repository;
  GetPersonUsecase({
    required this.repository,
  });

  Future<Person> execute(String ref) async{
    return repository.getPersonByRef(ref);
  }
}