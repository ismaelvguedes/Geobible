import 'package:flutter/material.dart';
import 'package:geobible/modules/home/composer/usecases/get_person_usecase.dart';
import 'package:provider/provider.dart';
import 'package:geobible/settings/app_routes.dart';
import 'package:geobible/factory/person_factory.dart';
import 'package:geobible/modules/home/composer/usecases/create_person_usecase.dart';
import 'package:geobible/modules/home/composer/usecases/delete_person_usecase.dart';
import 'package:geobible/modules/home/composer/usecases/stream_persons_usecase.dart';
import 'package:geobible/modules/home/composer/usecases/update_person_usecase.dart';
import 'package:geobible/modules/home/view/pages/add_person_page.dart';

// Google Fonts
import 'package:google_fonts/google_fonts.dart';

// Firebase
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

// Pages of home
import 'package:geobible/modules/home/view/pages/home_page.dart';
import 'package:geobible/modules/home/controller/home_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>(
          create: (context) => HomeController(
            streamPersonsUsecase:
                StreamPersonsUsecase(repository: PersonFactory.repository),
            createPersonUsecase:
                CreatePersonUsecase(repository: PersonFactory.repository),
            updatePersonUsecase:
                UpdatePersonUsecase(repository: PersonFactory.repository),
            deletePersonUsecase:
                DeletePersonUsecase(repository: PersonFactory.repository),
            getPersonUsecase:
                GetPersonUsecase(repository: PersonFactory.repository),
          ),
        )
      ],
      child: MaterialApp(
        title: "GeoBible",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber[400]!,
            brightness: Brightness.light,
          ),
          textTheme: GoogleFonts.aBeeZeeTextTheme(),
        ),
        initialRoute: AppRoutes.HOME,
        routes: {
          AppRoutes.HOME: (context) => const HomePage(),
          AppRoutes.ADD_PERSON: (context) => const AddPersonPage(),
        },
      ),
    );
  }
}
