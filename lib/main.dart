import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_demo_app2/services/database_services.dart';
import 'package:riverpod_demo_app2/services/http_service.dart';
import 'package:riverpod_demo_app2/views/home_screen.dart';

void main() async {
  await setupService();
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

//register service
Future<void> setupService() async {
  GetIt.instance.registerSingleton<HTTPService>(
    HTTPService(),
  );
  GetIt.instance.registerSingleton<DatabaseServices>(
    DatabaseServices(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokieeApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
