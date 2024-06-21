import 'package:geobible/modules/home/composer/repository/person_repository.dart';
import 'package:geobible/modules/home/data/repository/person_impl_repository.dart';
import 'package:geobible/modules/home/data/services/person_impl_services.dart';

abstract class PersonFactory {
  static PersonRepository repository = PersonImplRepository(
    services: PersonImplService(),
  );
}