import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_prog_genius/features/home/presentation/screens/home_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: const Game(),
    ),
  );
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff0F1518),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff0F1518),
          titleTextStyle: TextStyle(color: Colors.white, fontSize:  20),
          iconTheme: IconThemeData(color: Colors.white)
        ),
      ),
      home: HomeScreen(),
    );
  }
}
