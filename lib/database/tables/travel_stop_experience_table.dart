class TravelStopExperienceTable {
  static const String tableName = "travel_stop_experiences";
  static const String id = "id";
  static const String stopId = "stop_id";
  static const String comment = "comment";
  static const String photoPath = "photo_path";
  static const String createdAt = "created_at";

  static const String createTable = '''
    CREATE TABLE $tableName (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $stopId INTEGER NOT NULL,
      $comment TEXT,
      $photoPath TEXT,
      $createdAt TEXT NOT NULL,
      FOREIGN KEY ($stopId) REFERENCES travelStop(id) ON DELETE CASCADE
    )
  ''';
}
