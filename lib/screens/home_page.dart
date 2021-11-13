import 'dart:io';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:incident_reporter/bloc/incident_bloc.dart';
import 'package:incident_reporter/dao/incident_dao.dart';
import 'package:incident_reporter/model/incident.dart';
import 'package:incident_reporter/utils/utility.dart';
import 'package:incident_reporter/widgets/incident_view.dart';
import 'package:incident_reporter/widgets/profile_widget.dart';
import 'package:date_time_picker/date_time_picker.dart';

class Home extends StatefulWidget {
  static const route = "/home";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final IncidentBloc incidentBloc = IncidentBloc();
  int _selectedIndex = 0;
  DateTime _date = new DateTime.now();
  late String imgString;
  Future<List<Incident>>? incidents;
  int curId = 1;
  var incidentDao;
  bool? isUpdating;

  @override
  void initState() {
    super.initState();
    incidentDao = IncidentDao();
    isUpdating = false;
  }

  refreshList() {
    setState(() {
      incidents = incidentDao.getIncidents();
    });
  }

  getImagefromCamera() {
    ImagePicker().pickImage(source: ImageSource.camera).then((imgFile) {
      final _image = File(imgFile!.path);
      imgString = Utility.base64String(_image.readAsBytesSync());
    });
  }

  getImagefromGallery() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((imgFile) {
      final _image = File(imgFile!.path);
      imgString = Utility.base64String(_image.readAsBytesSync());
    });
  }

  List<Widget> _pages = <Widget>[
    IncidentWidget(
      title: '',
    ),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey.withOpacity(.70),
            items: [
              BottomNavigationBarItem(
                label: 'Incident',
                icon: Icon(Icons.dangerous),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person),
              )
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: FloatingActionButton(
            elevation: 5.0,
            onPressed: () {
              _showAddIncidentSheet(context);
            },
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              size: 32,
              color: Colors.blue,
            ),
          ),
        ));
  }

  void _showAddIncidentSheet(BuildContext context) {
    final _incidentDescriptionFormController = TextEditingController();
    final _incidentTypeFormController = TextEditingController();
    final _incidentDateTimeController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 350,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _incidentDescriptionFormController,
                          textInputAction: TextInputAction.newline,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: 'Description..',
                            labelText: 'New Incident',
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Empty description!';
                            }
                            return value.contains('')
                                ? 'Do not use the @ char.'
                                : null;
                          },
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _incidentTypeFormController,
                          textInputAction: TextInputAction.newline,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                          autofocus: false,
                          decoration: const InputDecoration(
                            hintText: 'Incident Type..',
                            labelText: 'Incident Type',
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Empty type!';
                            }
                            return value.contains('')
                                ? 'Do not use the @ char.'
                                : null;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: DateTimePicker(
                        type: DateTimePickerType.dateTime,
                        controller: _incidentDateTimeController,
                        dateLabelText: 'Date - Time',
                        dateHintText: 'Date - Time',
                        //fieldLabelText: 'Date - Time',
                        initialDate: _date,
                        firstDate: DateTime(2000, 1),
                        lastDate: DateTime(2100, 12),
                        onChanged: (selectedDateTime) {
                          _incidentDateTimeController.text =
                              selectedDateTime.toString();
                        },
                      )),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: getImagefromCamera,
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                //padding: EdgeInsets.all(20)
                              ),
                              child: Icon(Icons.camera_alt_rounded)),
                          ElevatedButton(
                              onPressed: getImagefromGallery,
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                //padding: EdgeInsets.all(20)
                              ),
                              child: Icon(Icons.image_aspect_ratio_rounded)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, top: 15),
                    child: CircleAvatar(
                      radius: 30,
                      child: IconButton(
                        icon: Icon(
                          Icons.save,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          final newIncident = Incident(
                              desc:
                                  _incidentDescriptionFormController.value.text,
                              dateTime: _incidentDateTimeController.value.text,
                              id: curId,
                              iimage: imgString,
                              itype: _incidentTypeFormController.value.text);
                          if (newIncident.desc.isNotEmpty) {
                            /*Create new Incident object and make sure
                                  the Incident description is not empty,
                                  because what's the point of saving empty
                                  Todo
                                  */
                            incidentBloc.addIncident(newIncident);

                            //dismisses the bottomsheet
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class HomeArgument {
  final User user;

  HomeArgument({required this.user});
}
