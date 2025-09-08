class ParticipantTable {
  static const String tableName = 'participants';
  static const String participantId = 'participantId';
  static const String name = 'name';
  static const String birthdate = 'birthdate';
  static const String photoPath = 'photoPath';

  static const String createTable = '''
    CREATE TABLE $tableName (
      $participantId INTEGER PRIMARY KEY AUTOINCREMENT,
      $name TEXT NOT NULL,
      $birthdate TEXT NOT NULL,
      $photoPath TEXT NOT NULL
    );
  ''';
}
