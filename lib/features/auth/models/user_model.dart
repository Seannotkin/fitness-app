class UserModel {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;
  final double? weightKg;
  final double? heightCm;
  final int? age;
  final String? goal; // 'lose_weight', 'build_muscle', 'stay_fit'

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    this.weightKg,
    this.heightCm,
    this.age,
    this.goal,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'createdAt': createdAt.toIso8601String(),
        'weightKg': weightKg,
        'heightCm': heightCm,
        'age': age,
        'goal': goal,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        createdAt: DateTime.parse(map['createdAt']),
        weightKg: map['weightKg']?.toDouble(),
        heightCm: map['heightCm']?.toDouble(),
        age: map['age'],
        goal: map['goal'],
      );
}
