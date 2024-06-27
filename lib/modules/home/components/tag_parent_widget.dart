import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geobible/modules/home/data/model/person.dart';
import 'package:geobible/modules/home/utils/home_functions.dart';
import 'package:geobible/modules/home/controller/home_controller.dart';

class TagParentWidget extends StatefulWidget {
  const TagParentWidget({
    super.key,
    required this.title,
    required this.reference,
    required this.color,
  });

  final String title;
  final String reference;
  final Color color;

  @override
  State<TagParentWidget> createState() => _TagParentWidgetState();
}

class _TagParentWidgetState extends State<TagParentWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            widget.reference.isNotEmpty
                ? FutureBuilder(
                    future: context
                        .read<HomeController>()
                        .getPerson(widget.reference),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox(
                            width: 10,
                            height: 10,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ));
                      } else if (snapshot.data.runtimeType == Person) {
                        return InkWell(
                          onTap: () {
                            context.read<HomeController>().searchPerson =
                                snapshot.data!.name;
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.transparent,
                                foregroundImage: HomeFunctions.imageLoadPerson(
                                  snapshot.data!.sex,
                                  snapshot.data!.imageURL,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                snapshot.data!.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox(child: Text("Error#!"));
                      }
                    })
                : const Text(
                    "Desconhecido",
                    style: TextStyle(color: Colors.white),
                  )
          ],
        ),
      ),
    );
  }
}
