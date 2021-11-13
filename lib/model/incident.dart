class Incident {
  int id;
  String itype;
  String dateTime;
  String desc;
  String iimage;

  Incident({
    required this.id,
    required this.itype,
    required this.dateTime,
    required this.desc,
    required this.iimage,
  });

  factory Incident.fromDatabaseJson(Map<String, dynamic> data) => Incident(
        id: data['id'],
        desc: data['description'],
        itype: data['incident_type'],
        dateTime: data['date_time'],
        iimage: data['image'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'id': this.id,
        'description': this.desc,
        'incident_type': this.itype,
        'date_time': this.dateTime,
        'image': this.iimage,
      };
}
