class ParcoursList {
  int id;
  String nom;

  ParcoursList(this.id, this.nom);

  ParcoursList.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nom = map["nom"];
}
