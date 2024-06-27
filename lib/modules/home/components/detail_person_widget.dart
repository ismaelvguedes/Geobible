import 'package:flutter/material.dart';
import 'package:geobible/modules/home/data/model/person.dart';
import 'package:geobible/modules/home/components/tag_parent_widget.dart';

const TextStyle textStyle = TextStyle(
  fontSize: 20,
  color: Colors.grey,
);

class DetailPersonWidget extends StatelessWidget {
  const DetailPersonWidget({
    super.key,
    required this.image,
    required this.person,
  });

  final ImageProvider<Object> image;
  final Person person;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              Card(
                shape: const CircleBorder(),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  foregroundImage: image,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        person.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Text(
                            person.sex[0].toUpperCase() +
                                person.sex.substring(1),
                            style: textStyle,
                          ),
                          const SizedBox(width: 5),
                          const Text('-', style: textStyle),
                          const SizedBox(width: 5),
                          Text(
                            person.ref,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red[600],
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              person.description.isEmpty ? "Sem descrição" : person.description,
              style: TextStyle(color: Colors.grey[800]),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              TagParentWidget(
                title: "Pai:",
                reference: person.father,
                color: Colors.blue[600]!,
              ),
              const SizedBox(width: 20),
              TagParentWidget(
                title: "Mãe:",
                reference: person.mother,
                color: Colors.pink[600]!,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/**
 * person.father.isNotEmpty
                        ? 
                        : const SizedBox(
                            child: Text("Não possui"),
                          )
 */
