import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/model.dart';

class Etablissements extends StatefulWidget {
  @override
  _EtablissementsState createState() => _EtablissementsState();
}

class _EtablissementsState extends State<Etablissements> {
  List<Etablissement> list;
  @override
  void initState() {
    list = listEtablissement;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar(),
      body: grid(),
    );
  }

  Container grid() {
    return Container(
      child: GridView.builder(
        itemCount: list.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                ((Get.width <= 1000 && Get.width > 810) || (Get.width < 600))
                    ? 2
                    : 3),
        itemBuilder: (context, index) {
          return Tooltip(
            message: 'Afficher plus de détail',
            child: InkWell(
              hoverColor: primary,
              onTap: () {
                Get.snackbar('${list[index].nom}', '${list[index].ville}');
                // Get.defaultDialog(
                //   backgroundColor: Colors.white,
                //   content: Column(
                //     children: [
                //       Expanded(
                //         child: Image.asset(
                //           listEtablissement[index].image,
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //       Expanded(
                //         child: Container(
                //           child: Column(
                //             children: [
                //               Text(
                //                 listEtablissement[index].nom,
                //                 style: TextStyle(
                //                     fontFamily: 'Didac',
                //                     fontSize: 24,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //               Text(
                //                 listEtablissement[index].ville,
                //                 style: TextStyle(
                //                   fontFamily: 'Didac',
                //                   fontSize: 18,
                //                 ),
                //               ),
                //               Text(
                //                 listEtablissement[index].description,
                //                 style: TextStyle(
                //                   fontFamily: 'Didac',
                //                   fontSize: 14,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: primary,
                  elevation: 8.8,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              list[index].image,
                              // height: ((Get.width <= 1000 && Get.width > 810) ||
                              //         (Get.width < 600))
                              //     ? 200
                              //     : 50.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                        child: ListView(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              list[index].nom,
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 25,
                                  color: Colors.white),
                            ),
                            Text(
                              list[index].ville,
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 18,
                                  color: Colors.white70),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar searchBar() {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Padding(
        padding:
            EdgeInsets.only(top: 10.0, right: 30.0, left: 30.0, bottom: 10),
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
                onPressed: () {},
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

// ListView.builder(
//           itemCount: list.length,
//           itemBuilder: (context, index) {
//             return (index == 0)
//                 ? Container()
//                 : Container(
//                     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                     height: 200.0,
//                     child: InkWell(
//                       onTap: () {},
//                       child: Card(
//                         elevation: 10.0,
//                         color: Colors.purple,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Image.asset(
//                                   list[index].image,
//                                   width: 400.0,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Container(
//                                 padding: EdgeInsets.only(
//                                   top: 8.0,
//                                 ),
//                                 height: double.infinity,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       list[index].nom,
//                                       style: TextStyle(
//                                           fontFamily: 'Ubuntu',
//                                           fontSize: 25,
//                                           color: Colors.white),
//                                     ),
//                                     SizedBox(
//                                       height: 5.0,
//                                     ),
//                                     Text(
//                                       list[index].ville,
//                                       style: TextStyle(
//                                           fontFamily: 'Ubuntu',
//                                           fontSize: 18,
//                                           color: Colors.white70),
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Expanded(
//                                         child: Text(
//                                       list[index].description,
//                                       style: TextStyle(
//                                           fontFamily: 'Ubuntu',
//                                           fontSize: 14,
//                                           color: Colors.white60),
//                                     ))
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//           },
//         ),
