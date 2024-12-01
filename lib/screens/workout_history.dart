import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WorkoutHistoryScreen extends StatefulWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  State<WorkoutHistoryScreen> createState() => _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            Text(
              'Completed Workouts',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('workouts')
                  .where('isChecked',
                      isEqualTo: true) 
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong!'));
                }

                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  List<DocumentSnapshot> completedWorkouts =
                      snapshot.data!.docs;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: completedWorkouts.length,
                      itemBuilder: (ctx, index) {
                        Map<String, dynamic> workoutData =
                            completedWorkouts[index].data()
                                as Map<String, dynamic>;
                        String workoutName = workoutData['name'];
                        int nSets = workoutData['sets'];
                        int nReps = workoutData['reps'];
                        int duration = workoutData['duration'];

                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Card(
                            elevation: 4,
                            child: ListTile(
                              title: Text(workoutName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Sets: $nSets'),
                                  Text('Reps: $nReps'),
                                  Text('Duration: $duration sec'),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: Text('No completed workouts found.'));
                }
              },
            ),

            SizedBox(
                height: 20), 

            
            Text(
              'Upcoming Workouts',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('workouts')
                  .where('isChecked',
                      isEqualTo: false) 
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong!'));
                }

                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  List<DocumentSnapshot> upcomingWorkouts = snapshot.data!.docs;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: upcomingWorkouts.length,
                      itemBuilder: (ctx, index) {
                        Map<String, dynamic> workoutData =
                            upcomingWorkouts[index].data()
                                as Map<String, dynamic>;
                        String workoutName = workoutData['name'];
                        int nSets = workoutData['sets'];
                        int nReps = workoutData['reps'];
                        int duration = workoutData['duration'];

                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Card(
                            elevation: 4,
                            child: ListTile(
                              title: Text(workoutName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Sets: $nSets'),
                                  Text('Reps: $nReps'),
                                  Text('Duration: $duration sec'),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: Text('No upcoming workouts found.'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
