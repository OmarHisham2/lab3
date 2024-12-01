import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab3/auth.dart';
import 'package:lab3/screens/login.dart';
import 'package:lab3/screens/workout_plan.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  String _enteredMail = '';
  String _enteredPassword = '';

  Future<void> _createUserWithEmailAndPassword() async {
    _formKey.currentState!.save();
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _enteredMail, password: _enteredPassword);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutPlansScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Weak password');
      } else if (e.code == 'email-already-in-use') {
        print('Account already exists');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Lab Assessment 3'),
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
                Row(
                  children: [
                    Text('Already have an account?'),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => LoginScreen()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: _createUserWithEmailAndPassword,
                  child: Text('Register'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
