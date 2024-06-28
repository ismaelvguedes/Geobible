import 'package:flutter/material.dart';
import 'package:geobible/modules/home/composer/usecases/create_person_usecase.dart';
import 'package:geobible/modules/home/composer/usecases/delete_person_usecase.dart';
import 'package:geobible/modules/home/composer/usecases/get_person_usecase.dart';
import 'package:geobible/modules/home/composer/usecases/stream_persons_usecase.dart';
import 'package:geobible/modules/home/composer/usecases/update_person_usecase.dart';
import 'package:geobible/modules/home/data/model/person.dart';

class HomeController with ChangeNotifier {
  final StreamPersonsUsecase streamPersonsUsecase;
  final CreatePersonUsecase createPersonUsecase;
  final UpdatePersonUsecase updatePersonUsecase;
  final DeletePersonUsecase deletePersonUsecase;
  final GetPersonUsecase getPersonUsecase;

  bool isProgress = false;

  final TextEditingController _searchPerson = TextEditingController(text: '');

  String get searchPerson {
    return _searchPerson.text;
  }

  set searchPerson(String value) {
    _searchPerson.text = value;
    update();
  }

  TextEditingController get searchController {
    return _searchPerson;
  }

  HomeController({
    required this.streamPersonsUsecase,
    required this.createPersonUsecase,
    required this.updatePersonUsecase,
    required this.deletePersonUsecase,
    required this.getPersonUsecase,
  });

  void update() {
    notifyListeners();
  }

  void startProgress() {
    isProgress = true;
    update();
  }

  void stopProgress() {
    isProgress = false;
    update();
  }

  Stream<List<Person>> streamPersons() {
    return streamPersonsUsecase.execute();
  }

  Future<void> createPerson(Person person) async {
    await createPersonUsecase.execute(person);
  }

  Future<void> updatePerson(Person person) async {
    await updatePersonUsecase.execute(person);
  }

  Future<void> deletePerson(Person person) async {
    await deletePersonUsecase.execute(person);
  }

  Future<Person> getPerson(String ref) async {
    return getPersonUsecase.execute(ref);
  }
}
