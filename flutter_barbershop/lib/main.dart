import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan binding sudah diinisialisasi
  await Firebase.initializeApp(); // Inisialisasi Firebase
  runApp(MyApp());
}

class TableCalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kalender")),
      body: Center(child: Text("Ini halaman kalender")),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData.dark(),
      home: WelcomeScreen(),
    );
  }
}