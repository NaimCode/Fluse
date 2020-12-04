import 'dart:typed_data';

//import 'package:firebase_web/firebase.dart' as fb;
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:website_university/constantes/couleur.dart';

import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:website_university/constantes/widget.dart';

class AjoutEtablissement extends StatefulWidget {
  @override
  _AjoutEtablissementState createState() => _AjoutEtablissementState();
}

class _AjoutEtablissementState extends State<AjoutEtablissement> {
  //initialisation
  final firestoreinstance = FirebaseFirestore.instance;

  //fb.StorageReference _ref = fb.storage().re;

  //Controller
  TextEditingController nomController = TextEditingController();
  TextEditingController villeController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController lienController = TextEditingController();
  ////Bool
  bool isCharging = false;
  bool emptyField = false;
  bool selected = false;

  ///diverses variables
  String imagePath;
  Uint8List image;
  String imageUrl;

  ///choisir une image
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

  uploadEtablissement() async {
    if (nomController.text != '' &&
        villeController.text != '' &&
        descController.text != '' &&
        lienController.text != '' &&
        image != null) {
      setState(() {
        isCharging = true;
        emptyField = false;
      });
      var future = await firestore().collection('Etablissement').get();

      print('after query');

      future.docs.forEach((element) {
        if (nomController.text == element.data()['nom'].toString()) {
          print('yes');
          return 'exist';
        }
      });

      var ref =
          FirebaseStorage.instance.ref().child('Etablissement/$imagePath');

      var uploadTask = ref.putData(image);
      await uploadTask.whenComplete(() async {
        imageUrl = await ref.getDownloadURL();
        print(imageUrl);
      });

      var etablissement = {
        'nom': nomController.text,
        'ville': villeController.text,
        'description': descController.text,
        'lien': lienController.text,
        'image': imageUrl,
      };

      firestoreinstance.collection('Etablissement').doc().set(etablissement);

      setState(() {
        nomController.clear();
        villeController.clear();
        descController.clear();
        lienController.clear();
        image = null;
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
  Widget build(BuildContext context) {
    return isCharging
        ? chargement()
        : Scaffold(
            backgroundColor: backColor,
            appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Text('Ajout d\'un établissement',
                    style: TextStyle(fontFamily: 'Ubuntu', fontSize: 20.0))),
            body: Center(
              child: Container(
                height: double.infinity,
                width: 810,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      //add image
                      Expanded(child: imageEtablissement()),
                      SizedBox(
                        height: 10,
                      ),
                      //nom de l'etablissment
                      nomTextField(),
                      SizedBox(
                        height: 10,
                      ),
                      //nom de l'etablissment
                      villeTextField(),
                      SizedBox(
                        height: 10,
                      ),
                      lienTextField(),
                      SizedBox(
                        height: 10,
                      ),
                      descTextField(),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: Builder(
              builder: (context) => FloatingActionButton(
                tooltip: 'Ajouter',
                onPressed: () async {
                  var check = await uploadEtablissement();

                  if (check == 'erreur')
                    Get.rawSnackbar(
                        title: 'Ajout d\'un établissement',
                        message:
                            'Erreur, vérifiez que vous avez saisi tous les champs!',
                        icon: Icon(
                          Icons.error,
                          color: Colors.red,
                        ));
                  if (check == 'succes')
                    Get.rawSnackbar(
                        title: 'Ajout d\'un établissement',
                        message: 'L\'établissement a été ajouté',
                        icon: Icon(
                          Icons.verified,
                          color: Colors.white,
                        ));
                  if (check == 'exist')
                    Get.rawSnackbar(
                        title: 'Ajout d\'un établissement',
                        message: 'L\'établissement existe déjà',
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
  }

  Tooltip imageEtablissement() {
    return Tooltip(
      message: 'Ajouter une image',
      child: InkWell(
        onTap: () {
          choisirImageEtablissement();
          setState(() {
            selected = true;
          });
        },
        child: Card(
          color: backColor,
          elevation: 6,
          child: Container(
            color: backColor,
            height: 300,
            width: 500,
            child: !selected
                ? Icon(
                    Icons.add_a_photo,
                    color: Colors.black45,
                  )
                : (image != null)
                    ? Image.memory(image, fit: BoxFit.contain)
                    : chargement(),
          ),
        ),
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
      //height: 50,
      width: 500,
      child: Stack(
        children: [
          TextFormField(
            controller: descController,
            keyboardType: TextInputType.multiline,
            maxLines: 4,
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

  Container villeTextField() {
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
            controller: villeController,
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 16, top: 11, right: 15),
                hintText: 'Nom de la ville...'),
          ),
        ],
      ),
    );
  }

  Container lienTextField() {
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
            controller: lienController,
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 16, top: 11, right: 15),
                hintText: 'Lien...'),
          ),
        ],
      ),
    );
  }

  Container nomTextField() {
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
            controller: nomController,
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 16, top: 11, right: 15),
                hintText: 'Nom de l\'établissement...'),
          ),
        ],
      ),
    );
  }
}
