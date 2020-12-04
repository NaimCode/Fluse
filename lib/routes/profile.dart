import 'dart:io' as io;
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_select/smart_select.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/model.dart';
import 'package:provider/provider.dart';
import 'dart:html';
import 'package:path/path.dart';
import 'package:website_university/constantes/widget.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final firestoreinstance = FirebaseFirestore.instance;
  Utilisateur user;
  bool modify = false;
  bool passVisibility = false;
  String semestre;
  String filiere;
  bool isCharging = false;
  bool nomExist = false;

  //Controller
  TextEditingController nomController = TextEditingController();
  TextEditingController universiteController = TextEditingController();

  ///choisir une image
  String imagePath;
  Uint8List image;
  String imageUrl;

  choisirImageEtablissement() async {
    InputElement uploadImage = FileUploadInputElement()..accept = 'image/*';
    uploadImage.click();
    uploadImage.onChange.listen((event) async {
      final file = uploadImage.files.first;
      imagePath = basename(file.name);
      final reader = FileReader();
      reader.readAsArrayBuffer(file);
      reader.onLoad.listen((event) {
        setState(() {
          image = reader.result;
        });
      });
    });
  }

  Future updateUser() async {
    // var future = await firestore().collection('Utilisateur').get();

    // future.docs.forEach((element) {
    //   print(element.data()['nom']);
    //   if (nomController.text == element.data()['nom'].toString()) {
    //     print('yes');
    //     exit(0);
    //   }
    // });

    var ref = FirebaseStorage.instance
        .ref()
        .child('Utilisateur/${user.uid}_$imagePath');

    if (image != null) {
      var uploadTask = ref.putData(image);
      await uploadTask.whenComplete(() async {
        imageUrl = await ref.getDownloadURL();
        print(imageUrl);
      });
    }

    var utilisateurs = {
      'nom': (nomController.text.isEmpty) ? user.nom : nomController.text,
      'image': (image == null) ? user.image : imageUrl,
      'universite': (universiteController.text.isEmpty)
          ? user.universite
          : universiteController.text,
      'semestre': (semestre == null) ? user.semestre : semestre,
      'filiere': (filiere == null) ? user.filiere : filiere,
    };
    try {
      await firestoreinstance
          .collection('Utilisateur')
          .doc(user.uid)
          .update(utilisateurs);
      setState(() {
        image = null;
        nomExist = false;
      });
      return 'Succes';
    } catch (e) {
      return 'Erreur';
    }
  }

  @override
  Widget build(BuildContext context) {
    user = context.watch<Utilisateur>();

    return isCharging
        ? chargement()
        : Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if (modify == true) {
                  setState(() {
                    isCharging = true;
                  });
                  var check = await updateUser();
                  setState(() {
                    isCharging = false;
                  });

                  switch (check) {
                    case 'Succes':
                      Get.rawSnackbar(
                          title: 'Modification',
                          message: 'Votre a été bien modifier',
                          icon: Icon(Icons.verified, color: Colors.white));

                      break;
                    default:
                      Get.rawSnackbar(
                          title: 'Modification',
                          message: 'Ce nom existe déjà',
                          icon: Icon(Icons.error, color: Colors.red));
                      setState(() {
                        nomExist = true;
                      });
                  }

                  setState(() {
                    modify = !modify;
                  });
                } else
                  setState(() {
                    modify = !modify;
                  });
              },
              child: !modify
                  ? Icon(Icons.edit, color: Colors.white)
                  : Icon(Icons.save, color: Colors.white),
              backgroundColor: primary,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        width: 500,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: Column(
                            children: [
                              imageSection(),
                              SizedBox(
                                height: 20,
                              ),
                              nom(),
                              SizedBox(
                                height: 10,
                              ),
                              email(),
                              SizedBox(
                                height: 10,
                              ),
                              university(),
                              SizedBox(
                                height: 10,
                              ),
                              filiereSection(),
                              SizedBox(
                                height: 10,
                              ),
                              semestreSection(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget imageSection() {
    return modify
        ? InkWell(
            onTap: () {
              choisirImageEtablissement();
            },
            child: Container(
                width: 500,
                height: 250,
                child: Stack(
                  children: [
                    Container(
                      width: 500,
                      height: 250,
                      child: (image == null)
                          ? Image.network(
                              user.image,
                              fit: BoxFit.cover,
                            )
                          : Image.memory(
                              image,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Container(
                      width: 500,
                      height: 250,
                      color: Colors.black.withOpacity(0.3),
                      child: Center(
                          child:
                              Icon(Icons.add_a_photo, color: Colors.white54)),
                    )
                  ],
                )),
          )
        : Container(
            width: 500,
            height: 250,
            child: Image.network(
              user.image,
              fit: BoxFit.cover,
            ),
          );
  }

  Widget nom() {
    return Container(
      width: 500,
      child: Row(
        children: [
          Tooltip(message: 'Nom', child: Icon(Icons.person, color: primary)),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  //                    <--- top side
                  color: !modify ? Colors.white : backColor,
                  width: 3.0,
                ),
              ),
              child: !modify
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                      child: SelectableText(
                        user.nom,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Didac',
                        ),
                      ),
                    )
                  : TextFormField(
                      controller: nomController,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Didac',
                          color: Colors.purple[900]),
                      //initialValue: user.nom,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 14, top: 14, right: 15),
                          hintText: user.nom),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget email() {
    return Container(
      child: Row(
        children: [
          Tooltip(message: 'Email', child: Icon(Icons.mail, color: primary)),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    //                    <--- top side
                    color: Colors.white,
                    width: 3.0,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  child: SelectableText(
                    user.email,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Didac',
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget university() {
    return Container(
      width: 500,
      child: Row(
        children: [
          Tooltip(
              message: 'Etablissement',
              child: Icon(Icons.school, color: primary)),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  //                    <--- top side
                  color: modify ? backColor : Colors.white,
                  width: 3.0,
                ),
              ),
              child: !modify
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                      child: SelectableText(
                        user.universite ?? 'Etablissement indéfini',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Didac',
                            color: (user.universite == null)
                                ? Colors.black26
                                : null),
                      ),
                    )
                  : TextFormField(
                      controller: universiteController,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Didac',
                          color: Colors.purple[900]),
                      // initialValue: user.universite,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 14, top: 14, right: 15),
                        hintText: user.universite,
                        hintStyle: TextStyle(
                          fontFamily: 'Didac',
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget semestreSection() {
    return Container(
      child: Row(
        children: [
          Tooltip(
              message: 'Semestre',
              child: Icon(Icons.analytics_outlined, color: primary)),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  //                    <--- top side
                  color: modify ? backColor : Colors.white,
                  width: 3.0,
                ),
              ),
              child: modify
                  ? SmartSelect<String>.single(
                      modalType: S2ModalType.bottomSheet,
                      placeholder: semestre ?? '',
                      title: 'Choisir un semestre',
                      value: semestre ?? '',
                      choiceItems: optionsSemestre,
                      onChange: (state) {
                        setState(() => semestre = state.value);
                      })
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                      child: SelectableText(
                        user.semestre ?? 'Semestre indéfini',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Didac',
                            color: (user.semestre == null)
                                ? Colors.black26
                                : null),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget filiereSection() {
    return Container(
      child: Row(
        children: [
          Tooltip(
              message: 'Filière', child: Icon(Icons.class_, color: primary)),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  //                    <--- top side
                  color: modify ? backColor : Colors.white,
                  width: 3.0,
                ),
              ),
              child: modify
                  ? SmartSelect<String>.single(
                      modalType: S2ModalType.bottomSheet,
                      placeholder: filiere ?? '',
                      title: 'Choisir une filière',
                      value: filiere ?? '',
                      choiceItems: optionsFiliere,
                      onChange: (state) {
                        setState(() => filiere = state.value);
                      })
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                      child: SelectableText(
                        user.filiere ?? 'Filière indéfinie',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Didac',
                            color:
                                (user.filiere == null) ? Colors.black26 : null),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
