//model de l'information
import 'package:website_university/constantes/string.dart';

//// Menu
List<String> listMenu = [
  'Etablissements',
  'Documents',
  'Home',
  'Support',
  'Contact',
];

///////
class Information {
  User user;
  String description;
  Document document;
  String date;
  Information({this.user, this.description, this.document, this.date});
}

//model discution
class Message {
  User user;
  String date;
  String message;
  Message({this.user, this.date, this.message});
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
  String module;
  String annee;
  String filiere;
  String urlPDF;
  Document(
      {this.titre,
      this.universite,
      this.filiere,
      this.semestre,
      this.description,
      this.urlPDF,
      this.annee,
      this.module});
}

//////////////////////
///////////////////
Document d = Document(
  annee: '2020-2021',
  module: 'Programmation',
  titre: 'Chapitre 2: langage Dart',
  universite: 'Ibn Tofail',
  semestre: 'S5',
  filiere: 'SMI',
  description:
      'C\'est le deuxième chapitre concernant les essentiels de Flutter',
);
User user = User(nom: 'Naim Abdelkerim', admin: true, image: 'avatar.jpg');
User user2 = User(nom: 'Ali', admin: false, image: 'avatar2.jpg');
Information info = Information(
    user: user,
    document: d,
    date: '14h:03 | 12-04-2020',
    description:
        'Nouveau fiche de cours hggggggghghg gkgfkkgf dddddddfff ggggggggggfgfgf');
Message m = Message(
    user: user, date: '04h:50 09/12/2020', message: 'Coucou tout le monde');
Message m2 = Message(
    user: user2,
    date: '07h:50 19/12/2020',
    message: 'Salut fhfhdn fdjfdfjfdjfdjf vhjdjfdfdjfjdb bmdjjdjfjdfjdf');

List<Information> listInfo = [info, info, info, info];
List<Message> listMessages = [m2, m, m2, m, m2];
