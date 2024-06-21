import 'package:flutter/material.dart';

class DetailPersonPage extends StatelessWidget {
  const DetailPersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes"),
        backgroundColor: Colors.amber[800],
      ),
    );
  }
}