import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab3/auth.dart';
import 'package:lab3/screens/workout_plan.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

const COLOR_INPUT_TEXT_LIGHT = Color(0xff5a5a58);
const COLOR_INPUT_OUTLINE_LIGHT = Color(0xff535151);

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String _enteredMail = '';
  String _enteredPassword = '';
  String? errorMessage = '';

  Future<void> _signInWithEmailAndPassword() async {
    _formKey.currentState!.save();
    try {
      await Auth().signInWithEmailAndPassword(
          email: _enteredMail, password: _enteredPassword);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutPlansScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text('Login'),
            Divider(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (value) {
                      _enteredMail = value!;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            const BorderSide(color: COLOR_INPUT_OUTLINE_LIGHT),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 55, 50, 50),
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelStyle: GoogleFonts.poppins(
                          color: COLOR_INPUT_TEXT_LIGHT, fontSize: 15.0),
                      filled: true,
                      fillColor: Colors.transparent,
                      label: Text('Mail'),
                      prefixIcon: Icon(Icons.mail),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      _enteredPassword = value!;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            const BorderSide(color: COLOR_INPUT_OUTLINE_LIGHT),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 55, 50, 50),
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelStyle: GoogleFonts.poppins(
                          color: COLOR_INPUT_TEXT_LIGHT, fontSize: 15.0),
                      filled: true,
                      fillColor: Colors.transparent,
                      label: Text('Password'),
                      prefixIcon: Icon(Icons.password),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Login'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
