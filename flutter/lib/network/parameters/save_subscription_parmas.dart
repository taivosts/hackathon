import 'dart:convert';

class SaveSubcriptionParmas {
  final int packageId;
  final int userId;

  SaveSubcriptionParmas({
    required this.packageId,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'packageId': packageId,
      'userId': userId,
    };
  }

  factory SaveSubcriptionParmas.fromMap(Map<String, dynamic> map) {
    return SaveSubcriptionParmas(
      packageId: map['packageId']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SaveSubcriptionParmas.fromJson(String source) =>
      SaveSubcriptionParmas.fromMap(json.decode(source));
}
