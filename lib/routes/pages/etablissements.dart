import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/model.dart';
import 'package:website_university/constantes/widget.dart';

class Etablissements extends StatefulWidget {
  @override
  _EtablissementsState createState() => _EtablissementsState();
}

class _EtablissementsState extends State<Etablissements> {
  /////List
  List listEtablissement = [];
  List listInitial = [];
  /////future
  var future;

  @override
  void initState() {
    future = getEtablissement();
    // TODO: implement initState
    super.initState();
  }

  getEtablissement() async {
    var future = await firestore().collection('Etablissement').get();

    print('after query');

    future.docs.forEach((element) {
      Etablissement model = Etablissement.fromMap(element.data());
      listInitial.add(model);
    });
    setState(() {
      listEtablissement = listInitial;
    });

    return 'Complete';
  }

  searchFunction() {
    List m = [];
    if (rechercheEtablissement.text.isEmpty) {
      m = listInitial;
    } else {
      for (Etablissement model in listInitial) {
        if (model.nom
                .toLowerCase()
                .contains(rechercheEtablissement.text.toLowerCase()) ||
            model.ville
                .toLowerCase()
                .contains(rechercheEtablissement.text.toLowerCase())) {
          m.add(model);
        }
      }
    }
    setState(() {
      listEtablissement = m;
    });
  }

  dispose() {
    super.dispose();
  }

  TextEditingController rechercheEtablissement = TextEditingController();
  //ScrollController scrollModel = ScrollController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return chargement();
        return Scaffold(
          appBar: searchBar(),
          body: grid(),
        );
      },
    );
  }

  Widget grid() {
    return (listEtablissement.isEmpty)
        ? Container(
            color: Colors.white,
            child: Center(
              child: Text(
                'Aucun établissement ou ville "${rechercheEtablissement.text}"',
                style: TextStyle(
                    fontFamily: 'Ubuntu', fontSize: 20, color: primary),
              ),
            ))
        : Scrollbar(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.builder(
                  itemCount: listEtablissement.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ((Get.width <= 1000 && Get.width > 810) ||
                              (Get.width < 600))
                          ? 1
                          : 2),
                  itemBuilder: (context, index) {
                    // String image = snapshot.data.docs[index].data()['image'];
                    // String nom = snapshot.data.docs[index].data()['nom'];
                    // String ville = snapshot.data.docs[index].data()['ville'];
                    // String description =
                    //     snapshot.data.docs[index].data()['description'];
                    // String lien = snapshot.data.docs[index].data()['lien'];

                    return Tooltip(
                      message: 'Afficher plus de détail',
                      child: InkWell(
                        hoverColor: primary,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: primary,
                            elevation: 8.8,
                            child: Container(
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: Image.network(
                                      listEtablissement[index].image,
                                      // height: ((Get.width <= 1000 && Get.width > 810) ||
                                      //         (Get.width < 600))
                                      //     ? 200
                                      //     : 50.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    color: primary.withOpacity(0.5),
                                    height: 100,
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.only(left: 8.0, bottom: 8.0),
                                    child: Scrollbar(
                                      // controller: scrollModel,
                                      // isAlwaysShown: true,
                                      child: ListView(
                                        children: [
                                          Text(
                                            listEtablissement[index].nom,
                                            style: TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontSize: 29,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            listEtablissement[index].ville,
                                            style: TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontSize: 18,
                                                color: Colors.white70),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )));
  }

  AppBar searchBar() {
    return AppBar(
      leading: null,
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Padding(
        padding:
            EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              //                    <--- top side
              color: backColor,
              width: 3.0,
            ),
          ),
          height: 50,
          child: Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: rechercheEtablissement,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 16, top: 11, right: 15),
                    hintText: 'Recherche'),
              )),
              IconButton(
                tooltip: 'Rechercher',
                alignment: Alignment.center,
                color: primary,
                onPressed: () {
                  searchFunction();
                },
                icon: Icon(
                  Icons.search,
                  color: primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
