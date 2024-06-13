import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geobible/settings/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';

// Pages of home 
import 'package:geobible/modules/home/view/pages/home_page.dart';
import 'package:geobible/modules/home/controller/home_controller.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>(
          create: (context) => HomeController(),
        )
      ],
      child: MaterialApp(
        title: "GeoBible",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green,
          textTheme: GoogleFonts.quicksandTextTheme(),
        ),
        initialRoute: AppRoutes.HOME,
        routes: {
          AppRoutes.HOME: (context) => const HomePage(),
        },
      ),
    );
  }
}