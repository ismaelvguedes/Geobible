import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geobible/settings/data_bible.dart';

class ReferenceInput extends StatefulWidget {
  final Function(String ref) onSaved;
  const ReferenceInput({super.key, required this.onSaved});

  @override
  State<ReferenceInput> createState() => _ReferenceInputState();
}

class _ReferenceInputState extends State<ReferenceInput> {
  Map book = {};
  String capitulo = '1';
  String versiculo = '1';

  void _saveValues() {
    setState(() {
      widget.onSaved("${book["abbr"]} $capitulo:$versiculo");
      debugPrint("${book["abbr"]} $capitulo:$versiculo");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.book,
                color: Colors.grey[700],
              ),
              const SizedBox(width: 10),
              Text(
                "Referência",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const Divider(height: 30),
          DropdownMenu<String>(
            label: const Text("Livro: "),
            width: MediaQuery.of(context).size.width - 92,
            initialSelection: DataBible.DATA.first["abbr"],
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.all(2),
            ),
            menuHeight: MediaQuery.of(context).size.height / 6,
            onSelected: (String? value) {
              setState(() {
                book = DataBible.DATA[int.parse(value!)];
                _saveValues();
              });
            },
            dropdownMenuEntries: DataBible.DATA.map(
              (book) {
                return DropdownMenuEntry<String>(
                  value: DataBible.DATA.indexOf(book).toString(),
                  label: book["name"],
                );
              },
            ).toList(),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextFormField(
                  initialValue: capitulo,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Capítulo",
                  ),
                  onChanged: (value) {
                    capitulo = value;
                    _saveValues();
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: TextFormField(
                  initialValue: versiculo,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Versiculo",
                  ),
                  onChanged: (value) {
                    versiculo = value;
                    _saveValues();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
