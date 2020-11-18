//model de l'information
class Information {
  User user;
  String description;
  Document document;
  String date;
}

//model de l'utilisateur
class User {
  String nom;
  bool admin;
  String image;
  User({this.nom, this.admin, this.image});
}

//model d'un document
class Document {
  String titre;
  String description;
  String semestre;
  String universite;
  String filiere;
  String urlPDF;
}
