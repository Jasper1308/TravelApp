class Participant {
  final int participantId;
  final String name;
  final DateTime birthdate;
  final String photoPath;

  const Participant({
    required this.participantId,
    required this.name,
    required this.birthdate,
    required this.photoPath,
  });

  factory Participant.fromMap(Map<String, dynamic> map) {
    final idRaw = map['participantId'];
    final birthRaw = map['birthdate'];

    final id = idRaw is int
        ? idRaw
        : int.tryParse(idRaw?.toString() ?? '') ?? 0;

    DateTime birthdate;
    if (birthRaw is DateTime) {
      birthdate = birthRaw;
    } else if (birthRaw is String) {
      birthdate = DateTime.tryParse(birthRaw) ?? DateTime(1970);
    } else {
      birthdate = DateTime(1970);
    }

    return Participant(
      participantId: id,
      name: map['name'] as String? ?? '',
      birthdate: birthdate,
      photoPath: map['photoPath'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'participantId': participantId,
      'name': name,
      'birthdate': birthdate.toIso8601String(),
      'photoPath': photoPath,
    };
  }

  Participant copyWith({
    int? participantId,
    String? name,
    DateTime? birthdate,
    String? photoPath,
  }) {
    return Participant(
      participantId: participantId ?? this.participantId,
      name: name ?? this.name,
      birthdate: birthdate ?? this.birthdate,
      photoPath: photoPath ?? this.photoPath,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Participant && other.participantId == participantId;

  @override
  int get hashCode => participantId.hashCode;
}
