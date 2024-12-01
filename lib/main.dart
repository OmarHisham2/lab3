import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab3/firebase_options.dart';
import 'package:lab3/screens/login.dart';
import 'package:lab3/screens/sign_up.dart';
import 'package:lab3/screens/workout_plan.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignupScreen(),
    );
  }
}
