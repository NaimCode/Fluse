//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase/firestore.dart';

import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase/firebase.dart';
//import 'package:firebase_web/firebase.dart' as fb;
import 'package:path/path.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:website_university/constantes/couleur.dart';
import 'package:smart_select/smart_select.dart';
import 'package:website_university/constantes/model.dart';
import 'package:website_university/constantes/widget.dart';

class AjoutDocument extends StatefulWidget {
  Utilisateur user;
  AjoutDocument(this.user);
  @override
  _AjoutDocumentState createState() => _AjoutDocumentState();
}

class _AjoutDocumentState extends State<AjoutDocument> {
  final firestoreinstance = FirebaseFirestore.instance;
  String filiere = '';
  var future;
  bool emptyField = true;
  bool selected = true;
  var pdf;
  String pdfPath;
  String pdfUrl;

  bool isCharging = false;

  String semestre = '';
  String annee = '';

  choisirDoc() {
    InputElement uploadImage = FileUploadInputElement()
      ..accept = '.pdf,.doc,.docx,.xls,.xlsx,.txt,.ppt,.pptx';
    uploadImage.click();
    uploadImage.onChange.listen((event) async {
      var file = uploadImage.files.first;
      pdfPath = basename(file.name);
      final reader = FileReader();
      reader.readAsArrayBuffer(file);
      reader.onLoad.listen((event) {
        setState(() {
          pdf = reader.result;
        });
      });
    });
  }

  uploadDocument() async {
    if (titreController.text != '' &&
        descController.text != '' &&
        moduleController.text != '' &&
        pdf != null &&
        annee != '' &&
        filiere != '' &&
        semestre != '') {
      setState(() {
        isCharging = true;
        emptyField = false;
      });
      var future = await firestore().collection('Document').get();

      future.docs.forEach((element) {
        if (titreController.text == element.data()['titre'].toString() &&
            annee == element.data()['annee'].toString() &&
            filiere == element.data()['filiere'].toString()) return 'exist';
      });

      var ref = FirebaseStorage.instance.ref().child('Document/$pdfPath');

      var uploadTask = ref.putData(pdf);
      await uploadTask.whenComplete(() async {
        pdfUrl = await ref.getDownloadURL();
        print(pdfUrl);
      });

      var document = {
        'titre': titreController.text,
        'module': moduleController.text,
        'description': descController.text,
        'url': pdfUrl,
        'annee': annee,
        'semestre': semestre,
        'filiere': filiere,
      };

      var doc = await firestoreinstance.collection('Document').add(document);

      var information = {
        'username': widget.user.nom,
        'userimage': widget.user.image,
        'documentID': doc.id,
        'filiere': filiere,
        'semestre': semestre,
        'date': Timestamp.now(),
      };
      await firestoreinstance.collection('Notification').doc().set(information);
      setState(() {
        titreController.clear();
        moduleController.clear();
        descController.clear();
        pdf = null;
        selected = false;
        isCharging = false;
      });
      return 'succes';
    } else {
      setState(() {
        emptyField = true;
      });
      return 'erreur';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController titreController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController moduleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return chargement();
        return isCharging
            ? chargement()
            : Scaffold(
                backgroundColor: backColor,
                appBar: AppBar(
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    title: Text('Ajout d\'un document',
                        style:
                            TextStyle(fontFamily: 'Ubuntu', fontSize: 20.0))),
                body: Center(
                  child: Container(
                      height: double.infinity,
                      width: 810,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            pdfSection(),
                            SizedBox(
                              height: 10,
                            ),
                            titreTextField(),
                            SizedBox(
                              height: 10,
                            ),
                            moduleTextField(),
                            SizedBox(
                              height: 10,
                            ),
                            descTextField(),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 1.0,
                              child: optionsFiliere.isNotEmpty
                                  ? SmartSelect<String>.single(
                                      modalType: S2ModalType.bottomSheet,
                                      placeholder: '',
                                      title: 'Choisir une filière',
                                      value: filiere,
                                      choiceItems: optionsFiliere,
                                      onChange: (state) {
                                        setState(() => filiere = state.value);
                                        print('$filiere  a ete selectionne');
                                      })
                                  : chargement(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                                elevation: 1.0,
                                child: SmartSelect<String>.single(
                                    modalType: S2ModalType.bottomSheet,
                                    placeholder: '',
                                    title: 'Choisir un semestre',
                                    value: semestre,
                                    choiceItems: optionsSemestre,
                                    onChange: (state) {
                                      setState(() => semestre = state.value);
                                      print('$semestre a ete selectionne');
                                    })),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                                elevation: 1.0,
                                child: SmartSelect<String>.single(
                                    modalType: S2ModalType.bottomSheet,
                                    placeholder: '',
                                    title: 'Choisir une année',
                                    value: annee,
                                    choiceItems: optionsAnnee,
                                    onChange: (state) {
                                      setState(() => annee = state.value);
                                      print('$annee a ete selectionne');
                                    })),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )),
                ),
                floatingActionButton: Builder(
                  builder: (context) => FloatingActionButton(
                    tooltip: 'Ajouter',
                    onPressed: () async {
                      var check = await uploadDocument();

                      if (check == 'erreur')
                        Get.rawSnackbar(
                            title: 'Ajout d\'un document',
                            message:
                                'Erreur, vérifiez que vous avez saisi tous les champs!',
                            icon: Icon(
                              Icons.error,
                              color: Colors.red,
                            ));
                      if (check == 'succes')
                        Get.rawSnackbar(
                            title: 'Ajout d\'un document',
                            message: 'Le document a été ajouté',
                            icon: Icon(
                              Icons.verified,
                              color: Colors.white,
                            ));
                      if (check == 'exist')
                        Get.rawSnackbar(
                            title: 'Ajout d\'un document',
                            message: 'Le document existe déjà',
                            icon: Icon(
                              Icons.error_sharp,
                              color: Colors.yellow,
                            ));
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    backgroundColor: primary,
                  ),
                ),
              );
      },
    );
  }

  Container titreTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          //                    <--- top side
          color: backColor,
          width: 3.0,
        ),
      ),
      width: 500,
      child: Stack(
        children: [
          TextFormField(
            controller: titreController,
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 16, top: 11, right: 15),
                hintText: 'Titre...'),
          ),
        ],
      ),
    );
  }

  Container descTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          //                    <--- top side
          color: backColor,
          width: 3.0,
        ),
      ),
      width: 500,
      child: Stack(
        children: [
          TextFormField(
            controller: descController,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 16, top: 11, right: 15),
                hintText: 'Description...'),
          ),
        ],
      ),
    );
  }

  Container moduleTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          //                    <--- top side
          color: backColor,
          width: 3.0,
        ),
      ),
      width: 500,
      child: Stack(
        children: [
          TextFormField(
            controller: moduleController,
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 16, top: 11, right: 15),
                hintText: 'Module...'),
          ),
        ],
      ),
    );
  }

  pdfSection() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              choisirDoc();
            },
            child: Card(
              elevation: 6,
              color: (pdf != null) ? Colors.white : backColor,
              child: Container(
                height: (Get.width <= 810) ? 150 : 200,
                width: (Get.width <= 810) ? 150 : 200,
                child: Center(
                  child: (pdf != null)
                      ? Icon(Icons.verified, color: primary, size: 30)
                      : Icon(Icons.article, color: primary, size: 30),
                ),
              ),
            ),
          ),
          // Tooltip(
          //   message: (pdf != null) ? 'Vérifier' : 'Choisissez un document',
          //   child: RaisedButton(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10.0),
          //       ),
          //       color: primary,
          //       onPressed: selected ? () {} : null,
          //       child: Icon(
          //         Icons.visibility,
          //         color: Colors.white,
          //         size: 35,
          //       )),
          // )
        ],
      ),
    );
  }
}

// simple usage

// @override
// Widget build(BuildContext context) {

//   );
// }
