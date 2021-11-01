import 'package:incident_reporter/dao/incident_dao.dart';
import 'package:incident_reporter/model/incident.dart';

class IncidentRepository {
  final incidentDao = IncidentDao();

  Future getAllIncidents({String? query}) =>
      incidentDao.getIncidents(query: query);

  Future insertIncident(Incident incident) =>
      incidentDao.createIncident(incident);

  Future updateIncident(Incident incident) =>
      incidentDao.updateIncident(incident);

  Future deleteIncidentById(int id) => incidentDao.deleteIncident(id);

  //We are not going to use this in the demo
  Future deleteAllIncidents() => incidentDao.deleteAllIncidents();
}
