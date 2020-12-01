//model de l'information
import 'package:smart_select/smart_select.dart';
import 'package:website_university/constantes/string.dart';
import 'package:website_university/services/variableStatic.dart';

import '../main.dart';

//App
class Assets {
  String logo;
  String avatar1;
  String avatar2;
  Assets({this.logo, this.avatar1, this.avatar2});
}

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
  Usere user;
  String description;
  Document document;
  String date;

  Information({this.user, this.description, this.document, this.date});
}

//model discution
class Message {
  Usere user;
  String date;
  String message;
  Message({this.user, this.date, this.message});
}

//model de l'utilisateur
class Usere {
  String nom;
  bool admin;
  String image;
  Usere({this.nom, this.admin, this.image});
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
class Etablissement {
  String nom;
  String ville;
  String image;
  String description;
  String lien;
  Etablissement.fromMap(Map<String, dynamic> data) {
    nom = data['nom'];
    ville = data['ville'];
    image = data['image'];
    description = data['description'];
    lien = data['lien'];
  }
}

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
Usere user = Usere(
  nom: 'Naim Abdelkerim',
  admin: true,
  image: avatar,
);
Usere user2 = Usere(
  nom: 'Ali',
  admin: false,
  image: avatar2,
);
Information info = Information(
    user: user,
    document: d,
    date: '14h:03 | 12-04-2020',
    description: 'Nouveau fiche de cours');
Information info2 = Information(
    user: user,
    document: d,
    date: '16h:03 | 17-04-2020',
    description: 'Support du cours');
Message m = Message(
    user: user, date: '04h:50 09/12/2020', message: 'Coucou tout le monde');
Message m2 = Message(
    user: user2,
    date: '07h:50 19/12/2020',
    message: 'Salut fhfhdn fdjfdfjfdjfdjf vhjdjfdfdjfjdb bmdjjdjfjdfjdf');

List<Information> listInfo = [
  info,
  info2,
  info,
  info2,
  info2,
  info,
  info2,
  info
];
List<Message> listMessages = [
  m2,
  m,
];
List<S2Choice<String>> optionsSemestre = [
  S2Choice<String>(value: 'S1', title: 'S1'),
  S2Choice<String>(value: 'S2', title: 'S2'),
  S2Choice<String>(value: 'S3', title: 'S3'),
  S2Choice<String>(value: 'S4', title: 'S4'),
  S2Choice<String>(value: 'S5', title: 'S5'),
  S2Choice<String>(value: 'S6', title: 'S6'),
];
List<S2Choice<String>> optionsAnnee = [
  S2Choice<String>(value: '2020-2021', title: '2020-2021'),
  S2Choice<String>(value: '2019-2020', title: '2019-2020'),
  S2Choice<String>(value: '2018-2019', title: '2018-2019'),
  S2Choice<String>(value: '2017-2018', title: '2017-2018'),
  S2Choice<String>(value: '2016-2017', title: '2016-2017'),
  S2Choice<String>(value: '2015-2016', title: '2015-2016'),
  S2Choice<String>(value: '2014-2015', title: '2014-2015'),
  S2Choice<String>(value: '2013-2014', title: '2013-2014'),
  S2Choice<String>(value: '2012-2013', title: '2012-2013'),
  S2Choice<String>(value: '2011-2012', title: '2011-2012'),
];

class Utilisateur {
  String uid;
  String nom;
  String email;
  String password;
  String image;
  String filiere;
  String semestre;
  String universite;
  bool admin;
  Utilisateur.fromMap(Map<String, dynamic> data) {
    nom = data['nom'];
    uid = data['ville'];
    image = data['image'];
    email = data['email'];
    password = data['password'];
    filiere = data['filiere'];
    semestre = data['semestre'];
    universite = data['universite'];
    admin = data['admin'];
  }
  Utilisateur(
      {this.uid,
      this.nom,
      this.filiere,
      this.password,
      this.email,
      this.universite,
      this.semestre,
      this.image,
      this.admin});
}
