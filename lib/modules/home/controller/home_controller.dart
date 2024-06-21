import 'package:flutter/material.dart';
import 'package:geobible/modules/home/composer/usecases/create_person_usecase.dart';
import 'package:geobible/modules/home/composer/usecases/delete_person_usecase.dart';
import 'package:geobible/modules/home/composer/usecases/stream_persons_usecase.dart';
import 'package:geobible/modules/home/composer/usecases/update_person_usecase.dart';
import 'package:geobible/modules/home/data/model/person.dart';

class HomeController with ChangeNotifier {
  final StreamPersonsUsecase streamPersonsUsecase;
  final CreatePersonUsecase createPersonUsecase;
  final UpdatePersonUsecase updatePersonUsecase;
  final DeletePersonUsecase deletePersonUsecase;

  bool isProgress = false;

  HomeController({
    required this.streamPersonsUsecase,
    required this.createPersonUsecase,
    required this.updatePersonUsecase,
    required this.deletePersonUsecase,
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

  void createPerson(Person person) {
    createPersonUsecase.execute(person);
  }

  void updatePerson(Person person) {
    updatePersonUsecase.execute(person);
  }

  void deletePerson(Person person) {
    deletePersonUsecase.execute(person);
  }
}
