import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(HomeConstants.titleAppBar),
        backgroundColor: Colors.amber[800],
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              cursorColor: Colors.amber[800],
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 12),
                prefixIcon: Icon(Icons.search),
                hintText: "Pesquise um nome",
              ),
              onChanged: (String query) {
                context.read<HomeController>().searchPerson = query;
              },
            ),
          ),
          Consumer<HomeController>(
            builder: (context, homeController, child) => StreamBuilder(
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
                  final filteredItems = snapshot.data!.where((item) {
                    return item.name.toLowerCase().contains(homeController
                        .searchPerson
                        .toLowerCase());
                  }).toList();
                  filteredItems.sort((a, b) => a.name.compareTo(b.name));
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, id) => PersonWidget(
                        person: filteredItems[id],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
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
