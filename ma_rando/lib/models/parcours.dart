class Parcours {
  int? id;
  String? nom;
  double? distance;
  double? depart_lat;
  double? depart_lng;
  double? duree;
  int? difficulte;
  int? note;
  int? date;
  String? image;
  int? list;

  Parcours(this.id, this.nom, this.distance, this.depart_lat, this.depart_lng,
      this.duree, this.difficulte, this.note, this.date, this.image, this.list);

  Parcours.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nom = map["nom"],
        distance = map["distance"],
        depart_lat = map["depart_lat"],
        depart_lng = map["depart_lng"],
        duree = map["duree"],
        difficulte = map["difficulte"],
        note = map["note"],
        date = map["date"],
        image = map["image"],
        list = map["list"];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nom': nom,
      'distance': distance,
      'depart_lat': depart_lat,
      'depart_lng': depart_lng,
      'duree': duree,
      'difficulte': difficulte,
      'note': note,
      'date': date,
      'image': image,
      'list': list,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  @override
  String toString() {
    return 'Parcours{id: $id, nom: $nom, distance: $distance, depart_lat: $depart_lat, depart_lng: $depart_lng, duree: $duree, difficulte: $difficulte, note: $note, date: $date, image: $image, list: $list}';
  }
}
