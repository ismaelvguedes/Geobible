import 'package:flutter/material.dart';
import 'package:geobible/modules/home/components/person_select.dart';
import 'package:geobible/modules/home/components/radio_button.dart';
import 'package:geobible/modules/home/components/reference_input.dart';
import 'package:geobible/modules/home/components/text_input_form_icon.dart';
import 'package:geobible/modules/home/controller/home_controller.dart';
import 'package:geobible/modules/home/data/model/person.dart';
import 'package:provider/provider.dart';

class AddPersonPage extends StatefulWidget {
  const AddPersonPage({super.key});

  @override
  State<AddPersonPage> createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  String imageURL = "";
  bool loading = false;
  bool _hasFather = false;
  bool _hasMother = false;
  final _formKey = GlobalKey<FormState>();

  final _fName = FocusNode();
  final _fImageURL = FocusNode();
  final _fDescription = FocusNode();
  final _fRef = FocusNode();

  final _cName = TextEditingController();
  final _cImageURL = TextEditingController();
  final _cDescription = TextEditingController();
  final _cSex = TextEditingController(text: "homem");
  final _cRef = TextEditingController();
  final _cFather = TextEditingController();
  final _cMother = TextEditingController();

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
                    ReferenceInput(
                      onSaved: (ref) {
                        _cRef.text = ref;
                      },
                    ),
                    const SizedBox(height: 20),
                    RadioButton(
                      label: "Sexo:",
                      options: const ["Homem", "Mulher"],
                      selectOption: (key, value) {
                        _cSex.text = value.toLowerCase();
                      },
                    ),
                    const SizedBox(height: 20),
                    RadioButton(
                      selectedValue: 1,
                      label: "Tem pai:",
                      options: const ["Sim", "Não"],
                      selectOption: (key, value) {
                        setState(() {
                          if (value == "Sim") {
                            _hasFather = true;
                          } else {
                            _hasFather = false;
                          }
                          _cFather.text = "";
                        });
                      },
                    ),
                    if (_hasFather) ...[
                      const SizedBox(height: 20),
                      PersonSelect(
                        label: "Selecione o pai:",
                        onFilter: (person) => person.sex == "homem",
                        onSelected: (person) =>
                            _cFather.text = person?.id ?? "",
                      )
                    ],
                    const SizedBox(height: 20),
                    RadioButton(
                      selectedValue: 1,
                      label: "Tem mãe:",
                      options: const ["Sim", "Não"],
                      selectOption: (key, value) {
                        setState(() {
                          if (value == "Sim") {
                            _hasMother = true;
                          } else {
                            _hasMother = false;
                          }
                          _cMother.text = "";
                        });
                      },
                    ),
                    if (_hasMother) ...[
                      const SizedBox(height: 20),
                      PersonSelect(
                        label: "Selecione a mãe:",
                        onFilter: (person) => person.sex == "mulher",
                        onSelected: (person) =>
                            _cMother.text = person?.id ?? "",
                      )
                    ],
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: !loading
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                debugPrint([
                                  _cImageURL.text,
                                  _cName.text,
                                  _cDescription.text,
                                  _cRef.text,
                                  _cSex.text,
                                  _cFather.text,
                                  _cMother.text
                                ].toString());
                                context
                                    .read<HomeController>()
                                    .createPerson(
                                      Person(
                                        imageURL: _cImageURL.text,
                                        name: _cName.text,
                                        description: _cDescription.text,
                                        ref: _cRef.text,
                                        sex: _cSex.text,
                                        father: _cFather.text,
                                        mother: _cMother.text,
                                      ),
                                    )
                                    .then(
                                  (value) {
                                    Navigator.of(context).pop();
                                    context
                                    .read<HomeController>().searchPerson = _cName.text;
                                  },
                                );
                              } else {
                                setState(() {
                                  loading = false;
                                });
                              }
                            }
                          : null,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: !loading ? Colors.amber[800] : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: !loading
                              ? const Text(
                                  'SALVAR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      color: Colors.grey[800])),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
