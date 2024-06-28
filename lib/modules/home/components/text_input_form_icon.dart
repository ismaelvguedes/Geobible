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
          errorBorder: InputBorder.none,
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