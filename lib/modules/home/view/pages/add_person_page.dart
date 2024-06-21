import 'package:flutter/material.dart';

class TextInputFormIcon extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final Function(String value) onChanged;
  const TextInputFormIcon({
    super.key,
    required this.icon,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey)),
      child: TextFormField(
        cursorColor: Colors.amber[800],
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 12),
          prefixIcon: Icon(icon),
          hintText: hintText,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class AddPersonPage extends StatefulWidget {
  const AddPersonPage({super.key});

  @override
  State<AddPersonPage> createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  
  String imageURL = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo personagem"),
        backgroundColor: Colors.amber[800],
      ),
      backgroundColor: Colors.grey[100],
      body: Form(
        key: UniqueKey(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey[700],
                backgroundImage: imageURL.isEmpty
                    ? const NetworkImage(
                        "https://img.freepik.com/premium-vector/silhouette-adult-young-anonymous-man-white-background_464863-1235.jpg",
                      )
                    : NetworkImage(imageURL),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextInputFormIcon(
                      icon: Icons.image_search,
                      hintText: "Insira a URL da imagem",
                      onChanged: (value) {
                        setState(() {
                          imageURL = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextInputFormIcon(
                      icon: Icons.person,
                      hintText: "Insira o nome",
                      onChanged: (value) {
                      },
                    ),
                    const SizedBox(height: 20),
                    TextInputFormIcon(
                      icon: Icons.abc_rounded,
                      hintText: "Insira o significado",
                      onChanged: (value) {
                      },
                    ),
                    const SizedBox(height: 20),
                    TextInputFormIcon(
                      icon: Icons.textsms_outlined,
                      hintText: "Insira uma descrição",
                      onChanged: (value) {
                      },
                    ),
                    const SizedBox(height: 20),
                    TextInputFormIcon(
                      icon: Icons.book,
                      hintText: "Insira uma refêrencia",
                      onChanged: (value) {
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
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
        onPressed: () {},
      ),
    );
  }
}
