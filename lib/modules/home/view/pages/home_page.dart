import 'package:flutter/material.dart';
import 'package:geobible/modules/home/settings/home_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(HomeConstants.titleAppBar),
      ),
    );
  }
}