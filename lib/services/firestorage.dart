import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:website_university/constantes/model.dart';
import 'package:website_university/main.dart';
import 'package:website_university/services/variableStatic.dart';

getLogo() async {
  var ref = FirebaseStorage.instance.ref().child("Assets/logo.png");
  String url = (await ref.getDownloadURL());

  return url;
}

getAvatar1() async {
  var ref = FirebaseStorage.instance.ref().child("Assets/avatar.jpg");
  String url = (await ref.getDownloadURL()).toString();

  return url;
}

getAvatar2() async {
  var ref = FirebaseStorage.instance.ref().child("Assets/avatar2.jpg");
  String url = (await ref.getDownloadURL()).toString();

  return url;
}

Future getAssets() async {
  logo = await getLogo();
  avatar = await getAvatar1();
  avatar2 = await getAvatar2();
  return 'finish';
}

getEtablissement() async {
  return FirebaseFirestore.instance.collection('Etablissement').snapshots();
}

getEssai() async {
  var qn = await FirebaseFirestore.instance.collection('Etablissement').get();
  print(qn);
}
