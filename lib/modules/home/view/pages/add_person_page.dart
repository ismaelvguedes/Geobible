import 'package:flutter/material.dart';

class TextInputFormIcon extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final FocusNode focus;
  final FocusNode? nextFocus;
  final Function(String value)? onChanged;
  final String? initialValue;
  final Function(String? value)? onSaved;
  final String? Function(String? value)? validator;
  const TextInputFormIcon({
    super.key,
    required this.controller,
    required this.focus,
    this.nextFocus,
    required this.icon,
    required this.hintText,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        focusNode: focus,
        
        cursorColor: Colors.amber[800],
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 12),
          prefixIcon: Icon(icon),
          hintText: hintText,
        ),
        onChanged: onChanged,
        onSaved: onSaved,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(nextFocus);
        },
        validator: validator,
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
  bool enabled = true;
  final _formKey = GlobalKey<FormState>();

  final _fName = FocusNode();
  final _fImageURL = FocusNode();
  final _fDescription = FocusNode();
  final _fSex = FocusNode();
  final _fRef = FocusNode();

  final _cName = TextEditingController();
  final _cImageURL = TextEditingController();
  final _cDescription = TextEditingController();
  final _cSex = TextEditingController();
  final _cRef = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo personagem"),
        backgroundColor: Colors.amber[800],
      ),
      backgroundColor: Colors.grey[100],
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey[700],
                backgroundImage: imageURL.isEmpty
                    ? const AssetImage("assets/images/undefined.jpg")
                    : NetworkImage(imageURL),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextInputFormIcon(
                      controller: _cImageURL,
                      focus: _fImageURL,
                      nextFocus: _fName,
                      icon: Icons.image_search,
                      hintText: "Insira a URL da imagem",
                      onChanged: (value) {
                        setState(() {
                          imageURL = value;
                        });
                      },
                      onSaved: (value) {
                        return value ?? "";
                      },
                    ),
                    const SizedBox(height: 20),
                    TextInputFormIcon(
                      icon: Icons.person,
                      focus: _fName,
                      nextFocus: _fDescription,
                      controller: _cName,
                      hintText: "Insira o nome",
                      onSaved: (value) {
                        return value ?? "";
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Obrigatório";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextInputFormIcon(
                      controller: _cDescription,
                      focus: _fDescription,
                      nextFocus: _fRef,
                      icon: Icons.textsms_outlined,
                      hintText: "Insira uma descrição",
                      onSaved: (value) {
                        return value ?? "";
                      },
                    ),
                    const SizedBox(height: 20),
                    TextInputFormIcon(
                      icon: Icons.book,
                      controller: _cRef,
                      focus: _fRef,
                      nextFocus: _fSex,
                      hintText: "Insira uma refêrencia",
                      onSaved: (value) {
                        return value ?? "";
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Obrigatório";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextInputFormIcon(
                      icon: Icons.person_search_sharp,
                      controller: _cSex,
                      focus: _fSex,
                      hintText: "Insira o sexo(homem ou mulher)",
                      onSaved: (value) {
                        return value ?? "";
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Obrigatório";
                        }
                        return null;
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
          backgroundColor: enabled ? Colors.amber[800] : Colors.grey,
          padding: const EdgeInsets.all(15),
        ),
        icon: const Icon(
          Icons.save,
          size: 30,
        ),
        color: Colors.black,
        onPressed: enabled
            ? () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    enabled = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Salvando'),
                    ),
                  );
                } else {
                  setState(() {
                    enabled = true;
                  });
                }
              }
            : null,
      ),
    );
  }
}
