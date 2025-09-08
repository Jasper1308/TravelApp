class TravelTable {
  static const String tableName = 'travels';
  static const String travelId = 'travelId';
  static const String name = 'name';
  static const String initialDate = 'initialDate';
  static const String endDate = 'endDate';
  static const String transportType = 'transportType';

  static const String createTable = '''
    CREATE TABLE $tableName (
      $travelId INTEGER PRIMARY KEY AUTOINCREMENT,
      $name TEXT NOT NULL,
      $initialDate TEXT NOT NULL,
      $endDate TEXT NOT NULL,
      $transportType INTEGER NOT NULL
    );
  ''';
}
