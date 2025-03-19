import 'dart:convert';

class UserProfile {
  final String status; // Pending,
  final bool isActive;
  final String? fullName;
  final String? role;
  final String? email;
  final int id;
  final DateTime? dateOfBirth;
  final String? imageUrl;
  final List<String>? favoriteTopics;
  final int? weight;
  final int? height;

  UserProfile({
    required this.status,
    required this.isActive,
    this.fullName,
    this.role,
    this.email,
    required this.id,
    this.dateOfBirth,
    this.imageUrl,
    this.favoriteTopics,
    this.weight,
    this.height,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'isActive': isActive,
      'fullName': fullName,
      'role': role,
      'email': email,
      'id': id,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'imageUrl': imageUrl,
      'favoriteTopics': favoriteTopics,
      'weight': weight,
      'height': height,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      status: map['status'] ?? '',
      isActive: map['isActive'] ?? false,
      fullName: map['fullName'],
      role: map['role'],
      email: map['email'],
      id: map['id']?.toInt() ?? 0,
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.parse(map['dateOfBirth'])
          : null,
      imageUrl: map['imageUrl'],
      favoriteTopics: map['favoriteTopics'] == null
          ? null
          : List<String>.from(map['favoriteTopics']),
      weight: map['weight']?.toInt(),
      height: map['height']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source));
}

class SubmitedSubscription {
  final int? id;
  final bool? isExpired;

  SubmitedSubscription({required this.id, required this.isExpired});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isExpired': isExpired,
    };
  }

  factory SubmitedSubscription.fromMap(Map<String, dynamic> map) {
    return SubmitedSubscription(
      id: map['id']?.toInt(),
      isExpired: map['isExpired'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubmitedSubscription.fromJson(String source) =>
      SubmitedSubscription.fromMap(json.decode(source));
}
