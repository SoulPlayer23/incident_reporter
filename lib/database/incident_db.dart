import 'dart:async';
import 'dart:io';
import 'package:incident_reporter/model/incident.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final incidentTABLE = 'Incident';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  late Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveIncident.db is our database instance name
    String path = join(documentsDirectory.path, "ReactiveIncident.db");
    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $incidentTABLE ("
        "id INTEGER PRIMARY KEY, "
        "description TEXT, "
        "incident_type TEXT, "
        "date_time TEXT, "
        "image TEXT, "
        ")");
  }
}
