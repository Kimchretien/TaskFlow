import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taskflow/firebase_options.dart';
import 'package:taskflow/pages/login_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      home: LoginPage(
  title: 'Flutter Demo',
  isDarkMode: isDarkMode,
  onToggleTheme: toggleTheme,
),
    );
  }
}