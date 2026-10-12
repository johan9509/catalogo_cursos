import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AulaTechApp());
}

class AulaTechApp extends StatelessWidget {
  const AulaTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF101B3F);
    const blue = Color(0xFF4263EB);

    return MaterialApp(
      title: 'AulaTech - Catálogo de cursos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F7FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: blue,
          primary: blue,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}
