import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab3/firestore.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final _formKey =
      GlobalKey<FormState>(); 
  String _enteredName = '';
  int _enteredSets = 0;
  int _enteredReps = 0;
  int _enteredDuration = 0;
  
  Future<void> _addWorkout() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      try {
        
        firestoreService().addWorkout(
            _enteredName, _enteredSets, _enteredReps, _enteredDuration);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Workout added successfully!')),
        );
        Navigator.of(context).pop();
        
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add workout: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Workout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              
              TextFormField(
                onSaved: (value) {
                  _enteredName = value!;
                },
                decoration: InputDecoration(labelText: 'Workout Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a workout name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              
              TextFormField(
                onSaved: (value) {
                  _enteredSets = int.tryParse(value!)!;
                },
                decoration: InputDecoration(labelText: 'Number of Sets'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of sets';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              
              TextFormField(
                onSaved: (value) {
                  _enteredReps = int.tryParse(value!)!;
                },
                decoration: InputDecoration(labelText: 'Number of Reps'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of reps';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              
              TextFormField(
                onSaved: (value) {
                  _enteredDuration = int.tryParse(value!)!;
                },
                decoration: InputDecoration(labelText: 'Duration (seconds)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the workout duration';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              
              ElevatedButton(
                onPressed: _addWorkout,
                child: Text('Add Workout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
