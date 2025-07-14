class Participant {
  final String participantId;
  final String name;
  final String age;
  final String photoPath;

  Participant({
    required this.participantId,
    required this.name,
    required this.age,
    required this.photoPath,
  });

  factory Participant.fromMap(Map<String, dynamic> map) {
    return Participant(
      participantId: map['participantId'],
      name: map['name'],
      age: map['age'],
      photoPath: map['photoPath']
    );
  }
}
