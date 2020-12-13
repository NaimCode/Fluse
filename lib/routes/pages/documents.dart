import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_select/smart_select.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/model.dart';
import 'package:website_university/constantes/widget.dart';
import 'package:website_university/routes/pages/searchDoc.dart';

class Documents extends StatefulWidget {
  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  String asset;
  var future;
  String filiere;
  String semestre;
  getAssets() async {
    return await FirebaseStorage.instance
        .ref()
        .child("Assets/document.png")
        .getDownloadURL();
  }

  @override
  void initState() {
    future = getAssets();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return chargement();
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          child: Image.network(
                            snapshot.data,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Text(
                        'Vous cherchez un document spécifique?',
                        style: TextStyle(
                          fontFamily: 'Tomorrow',
                          fontSize: (Get.width <= 610) ? 18 : 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            //                    <--- top side
                            color: backColor,
                            width: 2.0,
                          ),
                        ),
                        child: SmartSelect<String>.single(
                            modalType: S2ModalType.bottomSheet,
                            placeholder: '',
                            title: 'Choisir une filière',
                            value: filiere,
                            choiceItems: optionsFiliere,
                            onChange: (state) {
                              setState(() => filiere = state.value);
                              print('$filiere  a ete selectionne');
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            //                    <--- top side
                            color: backColor,
                            width: 2.0,
                          ),
                        ),
                        child: SmartSelect<String>.single(
                            modalType: S2ModalType.bottomSheet,
                            placeholder: '',
                            title: 'Choisir un semestre',
                            value: semestre,
                            choiceItems: optionsSemestre,
                            onChange: (state) {
                              setState(() => semestre = state.value);
                              print('$semestre a ete selectionne');
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton.icon(
                        icon: Icon(
                          Icons.search,
                          size: 27,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Rechercher',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: (semestre == null || filiere == null)
                            ? null
                            : () {
                                Get.to(SearchDoc(
                                  filiere: filiere,
                                  semestre: semestre,
                                ));
                              },
                        color: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 60.0),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
