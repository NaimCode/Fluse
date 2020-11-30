import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_university/constantes/model.dart';
import 'package:website_university/routes/home.dart';

import 'package:website_university/routes/pages/ajoutEtablissement.dart';
import 'package:website_university/routes/pages/ajoutdocument.dart';
import 'package:website_university/services/firestorage.dart';
import 'package:website_university/splash.dart';

import 'constantes/widget.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(MyApp());
}

User user;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ibn Tofail',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: FluseWebsite(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FluseWebsite extends StatefulWidget {
  @override
  _FluseWebsiteState createState() => _FluseWebsiteState();
}

class _FluseWebsiteState extends State<FluseWebsite> {
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAssets(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return chargement();
        return Scaffold(
          body: Home(),
        );
      },
    );
  }
}
