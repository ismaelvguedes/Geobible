import 'package:flutter/material.dart';
import 'package:geobible/modules/home/components/person_widget.dart';
import 'package:geobible/modules/home/controller/home_controller.dart';
import 'package:geobible/modules/home/data/model/person.dart';
import 'package:provider/provider.dart';

class PersonSelect extends StatefulWidget {
  final String label;
  final bool Function(Person person) onFilter;
  final Function(Person? person) onSelected;

  const PersonSelect({
    super.key,
    required this.label,
    required this.onSelected,
    required this.onFilter,
  });

  @override
  State<PersonSelect> createState() => _PersonSelectState();
}

class _PersonSelectState extends State<PersonSelect> {
  Person? _person;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 15, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: TextStyle(color: Colors.grey[700]),
          ),
          _person != null
              ? FilledButton.icon(
                  onPressed: () {
                    setState(() {
                      _person = null;
                      widget.onSelected(null);
                    });
                  },
                  label: Text(_person!.name),
                  icon: const Icon(Icons.close),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.green,
                  ),
                )
              : FilledButton.icon(
                  style: FilledButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Consumer<HomeController>(
                        builder: (context, homeController, child) => Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextField(
                                controller: homeController.searchController,
                                cursorColor: Colors.amber[800],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.only(top: 12),
                                  prefixIcon: const Icon(Icons.search),
                                  hintText: "Pesquise um nome",
                                  suffixIcon: homeController
                                          .searchPerson.isNotEmpty
                                      ? IconButton(
                                          onPressed: () =>
                                              homeController.searchPerson = '',
                                          icon: const Icon(Icons.close),
                                        )
                                      : null,
                                ),
                                onChanged: (String query) {
                                  homeController.searchPerson = query;
                                },
                              ),
                            ),
                            StreamBuilder(
                              stream: homeController.streamPersons(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const SingleChildScrollView(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 10.0,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                              "Não existem personagens cadastrados!!"),
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  final filteredItems =
                                      snapshot.data!.where((item) {
                                    return widget.onFilter(item) &&
                                        item.name.toLowerCase().contains(
                                            homeController.searchPerson
                                                .toLowerCase()
                                                .trim());
                                  }).toList();
                                  filteredItems
                                      .sort((a, b) => a.name.compareTo(b.name));
                                  return Expanded(
                                    child: ListView.builder(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      itemCount: filteredItems.length,
                                      itemBuilder: (context, id) =>
                                          PersonWidget(
                                        person: filteredItems[id],
                                        actions: [
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              setState(() {
                                                widget.onSelected(
                                                    filteredItems[id]);
                                                _person = filteredItems[id];
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  label: const Text(
                    "escolha",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
        ],
      ),
    );
  }
}
