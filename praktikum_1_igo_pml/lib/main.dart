import 'package:flutter/material.dart';

import 'screens/mahasiswa_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Informasi Data Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0A2481)),
        useMaterial3: true,
      ),
      home: const MahasiswaListScreen(),
    );
  }
}
