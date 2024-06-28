import 'package:flutter/material.dart';
import 'package:geobible/modules/home/data/model/person.dart';
import 'package:geobible/modules/home/utils/home_functions.dart';
// ignore: constant_identifier_names


class PersonWidget extends StatelessWidget {
  final Person person;
  final List<Widget> actions;
  const PersonWidget({
    super.key,
    required this.person,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    String description = person.description;
    if (person.description.length >= 32) {
      List<String> preloadDescription =
          person.description.substring(0, 32).split(' ');
      preloadDescription.removeAt(preloadDescription.length - 1);
      if (preloadDescription.length >= 5) {
        preloadDescription.add("...");
      }
      description = preloadDescription.join(' ');
    }
    if (person.description.isEmpty) {
      description = "Sem descrição";
    }

    ImageProvider image = HomeFunctions.imageLoadPerson(person.sex, person.imageURL);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(57, 134, 134, 134),
            blurRadius: .2,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                foregroundImage: image,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(),
                  ),
                  Text(
                    person.ref,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ...actions,
        ],
      ),
    );
  }
}
