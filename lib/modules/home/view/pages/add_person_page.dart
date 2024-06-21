import 'package:flutter/material.dart';

class AddPersonPage extends StatefulWidget {
  const AddPersonPage({super.key});

  @override
  State<AddPersonPage> createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo personagem"),
        backgroundColor: Colors.amber[800],
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey[700],
              backgroundImage: const NetworkImage("https://img.freepik.com/premium-vector/silhouette-adult-young-anonymous-man-white-background_464863-1235.jpg"),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey)),
                    child: TextFormField(
                      cursorColor: Colors.amber[800],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 12),
                        prefixIcon: Icon(Icons.image_search),
                        hintText: "Insira a URL da imagem",
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey)),
                    child: TextFormField(
                      cursorColor: Colors.amber[800],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 12),
                        prefixIcon: Icon(Icons.person),
                        hintText: "Insira o nome",
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey)),
                    child: TextFormField(
                      cursorColor: Colors.amber[800],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 12),
                        prefixIcon: Icon(Icons.textsms_outlined),
                        hintText: "Insira uma descrição",
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: IconButton.filled(
        style: IconButton.styleFrom(
          backgroundColor: Colors.amber[800],
          padding: const EdgeInsets.all(15),
        ),
        icon: const Icon(
          Icons.save,
          size: 30,
        ),
        color: Colors.black,
        onPressed: (){},
      ),
    );
  }
}
