import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/play_mode_screen.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.green,
        ),
      ),
      home: PlayMode(),
      debugShowCheckedModeBanner: false,
    );
    
  }
}
