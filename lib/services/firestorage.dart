import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

getleft() async {
  var ref = FirebaseStorage.instance.ref().child("Assets/left1.png");
  String url = (await ref.getDownloadURL()).toString();

  return url;
}

getleft2() async {
  var ref = FirebaseStorage.instance.ref().child("Assets/left2.png");
  String url = (await ref.getDownloadURL()).toString();

  return url;
}

getright1() async {
  var ref = FirebaseStorage.instance.ref().child("Assets/right1.png");
  String url = (await ref.getDownloadURL()).toString();

  return url;
}

getright2() async {
  var ref = FirebaseStorage.instance.ref().child("Assets/right2.png");
  String url = (await ref.getDownloadURL()).toString();

  return url;
}

getprofile() async {
  var ref = FirebaseStorage.instance.ref().child("Assets/profile.png");
  String url = (await ref.getDownloadURL()).toString();

  return url;
}

getfacebook() async {
  var ref = FirebaseStorage.instance.ref().child("Assets/facebook.png");
  String url = (await ref.getDownloadURL()).toString();

  return url;
}

getgoogle() async {
  var ref = FirebaseStorage.instance.ref().child("Assets/google.png");
  String url = (await ref.getDownloadURL()).toString();

  return url;
}

getHome() async {
  var ref = FirebaseStorage.instance.ref().child("Assets/home.jpg");
  String url = (await ref.getDownloadURL()).toString();

  return url;
}

geteta() async {
  var ref = FirebaseStorage.instance.ref().child("Assets/etablissement");
  String url = (await ref.getDownloadURL()).toString();

  return url;
}

getdoc() async {
  var ref = FirebaseStorage.instance.ref().child("Assets/document.png");
  String url = (await ref.getDownloadURL()).toString();

  return url;
}

getabo() async {
  var ref = FirebaseStorage.instance.ref().child("Assets/about.png");
  String url = (await ref.getDownloadURL()).toString();

  return url;
}

getcon() async {
  var ref = FirebaseStorage.instance.ref().child("Assets/contact.png");
  String url = (await ref.getDownloadURL()).toString();

  return url;
}

Future getAssets() async {
  try {
    logo = await getLogo();
    avatar = await getAvatar1();
    avatar2 = await getAvatar2();
    left1 = await getleft();
    left2 = await getleft2();
    right1 = await getright1();
    right2 = await getright2();
    profile = await getprofile();
    googleLogo = await getgoogle();
    facebookLogo = await getfacebook();

    return 'finish';
  } catch (e) {
    print(e);
    return 'erreur';
  }
}
