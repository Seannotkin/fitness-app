class ExerciseSet {
  final int reps;
  final double weightKg;

  ExerciseSet({required this.reps, required this.weightKg});

  Map<String, dynamic> toMap() => {'reps': reps, 'weightKg': weightKg};

  factory ExerciseSet.fromMap(Map<String, dynamic> map) =>
      ExerciseSet(reps: map['reps'], weightKg: map['weightKg'].toDouble());
}

class Exercise {
  final String name;
  final List<ExerciseSet> sets;

  Exercise({required this.name, required this.sets});

  Map<String, dynamic> toMap() => {
        'name': name,
        'sets': sets.map((s) => s.toMap()).toList(),
      };

  factory Exercise.fromMap(Map<String, dynamic> map) => Exercise(
        name: map['name'],
        sets: (map['sets'] as List)
            .map((s) => ExerciseSet.fromMap(s))
            .toList(),
      );
}

class WorkoutModel {
  final String id;
  final String userId;
  final String name;
  final List<Exercise> exercises;
  final DateTime date;
  final int durationMinutes;

  WorkoutModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.exercises,
    required this.date,
    required this.durationMinutes,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'name': name,
        'exercises': exercises.map((e) => e.toMap()).toList(),
        'date': date.toIso8601String(),
        'durationMinutes': durationMinutes,
      };

  factory WorkoutModel.fromMap(Map<String, dynamic> map) => WorkoutModel(
        id: map['id'],
        userId: map['userId'],
        name: map['name'],
        exercises: (map['exercises'] as List)
            .map((e) => Exercise.fromMap(e))
            .toList(),
        date: DateTime.parse(map['date']),
        durationMinutes: map['durationMinutes'],
      );
}
