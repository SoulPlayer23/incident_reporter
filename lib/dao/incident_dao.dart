import 'dart:async';

import 'package:incident_reporter/database/incident_db.dart';
import 'package:incident_reporter/model/incident.dart';

class IncidentDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new incident records
  Future<Incident> createIncident(Incident incident) async {
    var db = await dbProvider.database;
    incident.id = db.insert(incidentTABLE, incident.toDatabaseJson()) as int;
    return incident;
  }

  //Get All incident items
  //Searches if query string was passed
  Future<List<Incident>> getIncidents(
      {List<String>? columns, String? query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>>? result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(incidentTABLE,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(incidentTABLE, columns: columns);
    }

    List<Incident> incidents = result!.isNotEmpty
        ? result.map((item) => Incident.fromDatabaseJson(item)).toList()
        : [];
    return incidents;
  }

  //Update incident record
  Future<int> updateIncident(Incident incident) async {
    final db = await dbProvider.database;

    var result = await db.update(incidentTABLE, incident.toDatabaseJson(),
        where: "id = ?", whereArgs: [incident.id]);

    return result;
  }

  //Delete incident records
  Future<int> deleteIncident(int id) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(incidentTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllIncidents() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      incidentTABLE,
    );

    return result;
  }
}
