class WeightEntry {
  final double weightKg;
  final DateTime date;

  WeightEntry({required this.weightKg, required this.date});

  Map<String, dynamic> toMap() => {
        'weightKg': weightKg,
        'date': date.toIso8601String(),
      };

  factory WeightEntry.fromMap(Map<String, dynamic> map) => WeightEntry(
        weightKg: map['weightKg'].toDouble(),
        date: DateTime.parse(map['date']),
      );
}

class ProfileModel {
  final String userId;
  final double? weightKg;
  final double? heightCm;
  final int? age;
  final String? goal; // 'lose_weight', 'build_muscle', 'stay_fit'
  final String? gender; // 'male', 'female', 'other'

  ProfileModel({
    required this.userId,
    this.weightKg,
    this.heightCm,
    this.age,
    this.goal,
    this.gender,
  });

  // Calculate BMI if height and weight are available
  double? get bmi {
    if (weightKg == null || heightCm == null) return null;
    final heightM = heightCm! / 100;
    return weightKg! / (heightM * heightM);
  }

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'weightKg': weightKg,
        'heightCm': heightCm,
        'age': age,
        'goal': goal,
        'gender': gender,
      };

  factory ProfileModel.fromMap(Map<String, dynamic> map) => ProfileModel(
        userId: map['userId'],
        weightKg: map['weightKg']?.toDouble(),
        heightCm: map['heightCm']?.toDouble(),
        age: map['age'],
        goal: map['goal'],
        gender: map['gender'],
      );
}
