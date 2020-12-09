import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_select/smart_select.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/model.dart';
import 'package:website_university/routes/pages/searchDoc.dart';

class Documents extends StatefulWidget {
  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  String filiere;
  String semestre;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Vous cherchez un document spécifique?',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
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
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
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
  }
}
