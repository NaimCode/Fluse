import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/model.dart';
import 'package:website_university/constantes/widget.dart';
import 'package:website_university/services/service.dart';

class SearchDoc extends StatefulWidget {
  final String semestre;
  final String filiere;
  SearchDoc({this.semestre, this.filiere});
  @override
  _SearchDocState createState() => _SearchDocState();
}

class _SearchDocState extends State<SearchDoc> {
  List listInitial = [];
  List list;
  var future;
  getDoc() async {
    var doc = await FirebaseFirestore.instance
        .collection('Document')
        .where('filiere', isEqualTo: widget.filiere)
        .where('semestre', isEqualTo: widget.semestre)
        .get();
    doc.docs.forEach((d) {
      listInitial.add(Document(
        annee: d['annee'],
        titre: d['titre'],
        module: d['module'],
        urlPDF: d['url'],
        semestre: d['semestre'],
        description: d['description'],
        filiere: d['filiere'],
      ));
    });
    setState(() {
      list = listInitial;
    });
    return 'Complete';
  }

  void initState() {
    future = getDoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: searchBar(),
      body: Center(
        child: Container(
          width: 810,
          //color: Colors.white,
          child: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return chargement();

              return (list.isEmpty)
                  ? Center(
                      child: Text('Aucun document'),
                    )
                  : Container(
                      width: 600,
                      child: Scrollbar(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 5,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      trailing: IconButton(
                                        tooltip: 'Télecharger',
                                        icon: Icon(Icons.cloud_download,
                                            color: primary),
                                        onPressed: () {
                                          downloadFile(list[index].urlPDF);
                                        },
                                      ),
                                      isThreeLine: true,
                                      tileColor: Colors.white,
                                      leading: Icon(
                                        Icons.article,
                                        color: primary,
                                        size: 35,
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SelectableText(list[index].titre,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontFamily: 'Ubuntu')),
                                          SelectableText(
                                              '${list[index].module}  |  ${list[index].filiere}  |  ${list[index].semestre}  |  ${list[index].annee}',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                  fontFamily: 'Ubuntu')),
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SelectableText(
                                              '${list[index].description}',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                  fontFamily: 'Ubuntu')),
                                        ],
                                      ),
                                    )),
                              );
                            },
                          ),
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }

  AppBar searchBar() {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      elevation: 4.0,
      centerTitle: true,
      title: Padding(
        padding:
            EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0, bottom: 10),
        child: Container(
          width: 700,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              //                    <--- top side
              color: backColor,
              width: 2.0,
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
