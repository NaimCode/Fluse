//model de l'information
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String username;
  String userimage;
  String filiere;
  String semestre;
  String documentID;
  DateTime date;
  // Information.fromMap(Map<String, dynamic> data) {
  //   userID = data['userID'];
  //   filiere = data['filiere'];
  //   documentID = data['documentID'];
  //   date = data['date'];
  //   semestre = data['semestre'];
  // }
  Information(
      {this.username,
      this.userimage,
      this.documentID,
      this.date,
      this.semestre,
      this.filiere});
}

//model discution
class Message {
  String userID;
  String date;
  String message;
  Message({this.userID, this.date, this.message});
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
  semestre: 'S5',
  filiere: 'SMI',
  description:
      'C\'est le deuxième chapitre concernant les essentiels de Flutter',
);

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
List<S2Choice<String>> optionsFiliere = [
  S2Choice<String>(value: 'SMI', title: 'SMI'),
  S2Choice<String>(value: 'Droit', title: 'Droit'),
  S2Choice<String>(value: 'Economie', title: 'Economie'),
  S2Choice<String>(value: 'SMPC', title: 'SMPC'),
  S2Choice<String>(value: 'SVU', title: 'SVU'),
];
List<S2Choice<String>> optionsChannel = [
  S2Choice<String>(value: 'Global', title: 'Global'),
  S2Choice<String>(value: 'SMI', title: 'SMI'),
  S2Choice<String>(value: 'Droit', title: 'Droit'),
  S2Choice<String>(value: 'Economie', title: 'Economie'),
  S2Choice<String>(value: 'SMPC', title: 'SMPC'),
  S2Choice<String>(value: 'SVU', title: 'SVU'),
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
  Utilisateur.fromDoc(var data) {
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

Utilisateur user = Utilisateur(
    nom: 'Naim',
    uid: 'blabla',
    image: profile,
    email: 'naim@gmail',
    password: '12345',
    filiere: null,
    semestre: null,
    universite: null,
    admin: true);
Utilisateur user2 = Utilisateur(
    nom: 'Ali',
    uid: 'fDaxcT1p5XY9UyvrT05DRbcYlrA2',
    image: avatar2,
    email: 'naim@gmail',
    password: '12345',
    filiere: null,
    semestre: null,
    universite: null,
    admin: false);
