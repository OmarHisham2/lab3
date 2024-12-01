import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab3/firestore.dart';
import 'package:lab3/screens/add_workout.dart';
import 'package:lab3/screens/workout_history.dart';

class WorkoutPlansScreen extends StatefulWidget {
  const WorkoutPlansScreen({super.key});

  @override
  State<WorkoutPlansScreen> createState() => _WorkoutPlansScreenState();
}

class _WorkoutPlansScreenState extends State<WorkoutPlansScreen> {
  
  Future<void> setChecked(String docID, bool isChecked) async {
    await firestoreService().updateWorkout(docID, isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => AddWorkoutScreen(),
            ),
          );
        },
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Current Workouts'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => WorkoutHistoryScreen()),
                );
              },
              icon: Icon(Icons.history))
        ],
      ),
      body: Column(
        children: [
          StreamBuilder(
            
            stream: FirebaseFirestore.instance
                .collection('workouts')
                .where('isChecked', isEqualTo: false) 
                .snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong!'));
              }

              if (snapshot.hasData) {
                List<DocumentSnapshot> myWorkouts = snapshot.data!.docs;

                return Expanded(
                  child: ListView.builder(
                    itemCount: myWorkouts.length,
                    itemBuilder: (ctx, index) {
                      DocumentSnapshot document = myWorkouts[index];
                      String docID = document.id;

                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;

                      String workoutName = data['name'];
                      int nSets = data['sets'];
                      int nReps = data['reps'];
                      int duration = data['duration'];

                      return Dismissible(
                        key: GlobalKey(),
                        onDismissed: (va) {
                          firestoreService().deleteWorkout(docID);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Workout Deleted successfully!')),
                          );
                        },
                        background: Container(
                          color: Colors.red,
                        ),
                        child: Card(
                          margin: EdgeInsets.all(10),
                          elevation: 5,
                          child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              title: Text(
                                workoutName,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Sets: $nSets'),
                                  Text('Reps: $nReps'),
                                  Text('Duration: $duration sec'),
                                ],
                              ),
                              trailing: Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        
                                        setChecked(docID, true);
                                      });
                                    },
                                    icon: Icon(Icons.check),
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                    child: Text('No workouts found, Start adding some!'));
              }
            },
          )
        ],
      ),
    );
  }
}
