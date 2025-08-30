class Participant {
  int participantId;
  final String name;
  final DateTime birthdate;
  final String photoPath;

  Participant({
    required this.participantId,
    required this.name,
    required this.birthdate,
    required this.photoPath,
  });

  factory Participant.fromMap(Map<String, dynamic> map) {
    return Participant(
      participantId: map['participantId'],
      name: map['name'],
      birthdate: DateTime.parse(map['birthdate']),
      photoPath: map['photoPath']
    );
  }
}
