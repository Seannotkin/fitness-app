import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/workout_model.dart';

class WorkoutService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save a completed workout
  Future<void> saveWorkout(WorkoutModel workout) async {
    await _db
        .collection('users')
        .doc(workout.userId)
        .collection('workouts')
        .doc(workout.id)
        .set(workout.toMap());
  }

  // Get all workouts for a user, newest first
  Future<List<WorkoutModel>> getWorkouts(String userId) async {
    final snapshot = await _db
        .collection('users')
        .doc(userId)
        .collection('workouts')
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => WorkoutModel.fromMap(doc.data()))
        .toList();
  }

  // Get workouts for a specific date range
  Future<List<WorkoutModel>> getWorkoutsByDateRange(
    String userId,
    DateTime from,
    DateTime to,
  ) async {
    final snapshot = await _db
        .collection('users')
        .doc(userId)
        .collection('workouts')
        .where('date', isGreaterThanOrEqualTo: from.toIso8601String())
        .where('date', isLessThanOrEqualTo: to.toIso8601String())
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => WorkoutModel.fromMap(doc.data()))
        .toList();
  }

  // Delete a workout
  Future<void> deleteWorkout(String userId, String workoutId) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('workouts')
        .doc(workoutId)
        .delete();
  }
}
