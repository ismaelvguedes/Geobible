import 'package:flutter/material.dart';
import 'package:geobible/modules/home/components/detail_person_widget.dart';
import 'package:geobible/settings/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:geobible/modules/home/components/person_widget.dart';
import 'package:geobible/modules/home/controller/home_controller.dart';
import 'package:geobible/modules/home/utils/home_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // int convertRefNumber(String ref){
  //   var sep1 = ref.split(' ');
  //   var sep2 = sep1[1].split(':');
  //   String cap = sep2[0];
  //   String ves = sep2[1];
  //   // DataBible.DATA[]
  //   return 0;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(HomeConstants.titleAppBar),
        backgroundColor: Colors.amber[800],
      ),
      backgroundColor: Colors.grey[100],
      body: Consumer<HomeController>(
        builder: (context, homeController, child) => Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: homeController.searchController,
                cursorColor: Colors.amber[800],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(top: 12),
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Pesquise um nome",
                  suffixIcon: homeController.searchPerson.isNotEmpty
                      ? IconButton(
                          onPressed: () => homeController.searchPerson = '',
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        children: [
                          Text("Não existem personagens cadastrados!!"),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final filteredItems = snapshot.data!.where(
                    (item) {
                      return item.name.toLowerCase().contains(
                            homeController.searchPerson.toLowerCase().trim(),
                          );
                    },
                  ).toList();
                  filteredItems.sort((a, b) => a.name.compareTo(b.name));
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, id) => PersonWidget(
                        person: filteredItems[id],
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.info),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                builder: (context) => DetailPersonWidget(
                                  person: filteredItems[id],
                                ),
                              );
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
      floatingActionButton: IconButton.filled(
        style: IconButton.styleFrom(
          backgroundColor: Colors.amber[800],
          padding: const EdgeInsets.all(15),
        ),
        icon: const Icon(
          Icons.add,
          size: 30,
        ),
        color: Colors.black,
        onPressed: () => Navigator.of(context).pushNamed(
          AppRoutes.ADD_PERSON,
        ),
      ),
    );
  }
}
