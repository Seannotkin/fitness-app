import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/profile_model.dart';

class ProfileService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save or update the user's profile
  Future<void> saveProfile(ProfileModel profile) async {
    await _db
        .collection('users')
        .doc(profile.userId)
        .collection('profile')
        .doc('data')
        .set(profile.toMap());
  }

  // Get the user's profile
  Future<ProfileModel?> getProfile(String userId) async {
    final doc = await _db
        .collection('users')
        .doc(userId)
        .collection('profile')
        .doc('data')
        .get();

    if (!doc.exists) return null;
    return ProfileModel.fromMap(doc.data()!);
  }

  // Log a new weight entry and update current weight
  Future<void> logWeight(String userId, double weightKg) async {
    // Update current weight on profile
    await _db
        .collection('users')
        .doc(userId)
        .collection('profile')
        .doc('data')
        .update({'weightKg': weightKg});

    // Also add to weight history for progress tracking
    await _db
        .collection('users')
        .doc(userId)
        .collection('weight_history')
        .add({
      'weightKg': weightKg,
      'date': DateTime.now().toIso8601String(),
    });
  }

  // Get full weight history for progress charts
  Future<List<WeightEntry>> getWeightHistory(String userId) async {
    final snapshot = await _db
        .collection('users')
        .doc(userId)
        .collection('weight_history')
        .orderBy('date', descending: false)
        .get();

    return snapshot.docs
        .map((doc) => WeightEntry.fromMap(doc.data()))
        .toList();
  }
}
