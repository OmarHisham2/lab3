import 'package:cloud_firestore/cloud_firestore.dart';

class firestoreService {
  final CollectionReference workouts =
      FirebaseFirestore.instance.collection('workouts');

  Future<void> addWorkout(
      String workoutName, int sets, int reps, int duration) {
    return workouts.add({
      'name': workoutName,
      'sets': sets,
      'reps': reps,
      'duration': duration,
      'isChecked': false,
      'timestamp': Timestamp.now()
    });
  }

  Stream<QuerySnapshot> getWorkouts() {
    final workoutStream =
        workouts.orderBy('timestamp', descending: true).snapshots();

    return workoutStream;
  }

  Future<void> updateWorkout(String docID, bool isChecked) {
    return workouts.doc(docID).update({'isChecked': isChecked});
  }

  Future<void> deleteWorkout(String docID) {
    return workouts.doc(docID).delete();
  }
}
