import 'package:flutter/material.dart';
import 'package:incident_reporter/bloc/incident_bloc.dart';
import 'package:incident_reporter/model/incident.dart';

class IncidentWidget extends StatefulWidget {
  IncidentWidget({Key? key, required this.title}) : super(key: key);
  final IncidentBloc incidentBloc = IncidentBloc();
  final String title;

  @override
  State<IncidentWidget> createState() => _IncidentWidgetState();
}

class _IncidentWidgetState extends State<IncidentWidget> {
  final IncidentBloc incidentBloc = IncidentBloc();
  final DismissDirection _dismissDirection = DismissDirection.horizontal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
              child: Container(
                  //This is where the magic starts
                  child: getIncidentsWidget()))),
    );
  }

  Widget getIncidentsWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (incidents)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: incidentBloc.incidents,
      builder: (BuildContext context, AsyncSnapshot<List<Incident>> snapshot) {
        return getIncidentCardWidget(snapshot);
      },
    );
  }

  Widget getIncidentCardWidget(AsyncSnapshot<List<Incident>> snapshot) {
    /*Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator*/
    if (snapshot.hasData) {
      /*Also handles whenever there's stream
      but returned returned 0 records of Incident from DB.
      If that the case show user that you have empty Incidents
      */
      return snapshot.data!.length != 0
          ? ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, itemPosition) {
                Incident incident = snapshot.data![itemPosition];
                final Widget dismissibleCard = new Dismissible(
                    background: Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Deleting",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      color: Colors.redAccent,
                    ),
                    onDismissed: (direction) {
                      /*The magic
                    delete Todo item by ID whenever
                    the card is dismissed
                    */
                      incidentBloc.deleteIncidentById(incident.id);
                    },
                    direction: _dismissDirection,
                    key: new ObjectKey(incident),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      child: ListTile(
                          title: Text(
                        incident.desc,
                        style: TextStyle(
                          fontSize: 16.5,
                          fontFamily: 'RobotoMono',
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ));
                return dismissibleCard;
              },
            )
          : Container(
              child: Center(
              //this is used whenever there 0 Incident
              //in the data base
              child: noIncidentMessageWidget(),
            ));
    } else {
      return Center(
        /*since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the use know the app is currently
        processing*/
        child: loadingData(),
      );
    }
  }

  Widget loadingData() {
    //pull todos again
    incidentBloc.getIncidents();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Loading...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget noIncidentMessageWidget() {
    return Container(
      child: Text(
        "Start adding Todo...",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }

  // ignore: must_call_super
  dispose() {
    /*close the stream in order
    to avoid memory leaks
    */
    incidentBloc.dispose();
  }
}
