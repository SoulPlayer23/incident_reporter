import 'dart:async';

import 'package:incident_reporter/model/incident.dart';
import 'package:incident_reporter/repo/incident_repo.dart';

class IncidentBloc {
  //Get instance of the Repository
  final _incidentRepository = IncidentRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _incidentController = StreamController<List<Incident>>.broadcast();

  get incidents => _incidentController.stream;

  IncidentBloc() {
    getIncidents();
  }

  getIncidents({String? query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _incidentController.sink
        .add(await _incidentRepository.getAllIncidents(query: query));
  }

  addIncident(Incident todo) async {
    await _incidentRepository.insertIncident(todo);
    getIncidents();
  }

  updateIncident(Incident todo) async {
    await _incidentRepository.updateIncident(todo);
    getIncidents();
  }

  deleteIncidentById(int id) async {
    _incidentRepository.deleteIncidentById(id);
    getIncidents();
  }

  dispose() {
    _incidentController.close();
  }
}
