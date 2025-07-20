import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'reservation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ReservationService.initializeWithSampleData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShoeVault Batangas Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: Colors.black87),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const LoginScreen(),
    );
  }
} 