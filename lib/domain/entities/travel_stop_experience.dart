class TravelStopExperience {
  final int? id;
  final int stopId;
  final String? comment;
  final String? photoPath;
  final DateTime createdAt;

  TravelStopExperience({
    this.id,
    required this.stopId,
    this.comment,
    this.photoPath,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stop_id': stopId,
      'comment': comment,
      'photo_path': photoPath,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory TravelStopExperience.fromMap(Map<String, dynamic> map) {
    return TravelStopExperience(
      id: map['id'] as int?,
      stopId: map['stop_id'] as int,
      comment: map['comment'] as String?,
      photoPath: map['photo_path'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
