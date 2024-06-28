import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  final int selectedValue;
  final String label;
  final List<String> options;
  final void Function(int key, String value) selectOption;

  const RadioButton({
    super.key,
    this.selectedValue = 0,
    required this.label,
    required this.options,
    required this.selectOption,
  });

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  int _selectedValue = 0;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.options.asMap().entries.map((entry) {
              int index = entry.key;
              String option = entry.value;
              return Row(children: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedValue = index;
                      widget.selectOption(index, option);
                    });
                  },
                  label: Text(
                    option,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  icon: Icon(
                    _selectedValue == index
                        ? Icons.radio_button_checked_sharp
                        : Icons.radio_button_off,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 10),
              ]);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
