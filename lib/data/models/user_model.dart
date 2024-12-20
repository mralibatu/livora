class User {
  final int id;
  final String name;
  final String surname;
  final String username;
  final String photo;
  final String password;
  final int? dailyGoal; // Nullable field
  final int streakCount;
  final String deviceId;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
    required this.photo,
    required this.password,
    this.dailyGoal,
    required this.streakCount,
    required this.deviceId,
  });

  // Factory method to create a User from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      username: json['username'],
      photo: json['photo'],
      password: json['password'],
      dailyGoal: json['daily_goal'], // Nullable field
      streakCount: json['streak_count'] ?? 0, // Default value of 0
      deviceId: json['device_id'],
    );
  }

  // Method to convert a User instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'photo': photo,
      'password': password,
      'daily_goal': dailyGoal,
      'streak_count': streakCount,
      'device_id': deviceId,
    };
  }
}
