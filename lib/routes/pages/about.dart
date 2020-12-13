import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/widget.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  double afEle = 0.0;
  double pcEle = 0.0;
  double devEle = 0.0;
  double tecEle = 0.0;
  var future;
  getAssets() async {
    return await FirebaseStorage.instance
        .ref()
        .child("Assets/about.png")
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
          print(snapshot.data);
          return Scaffold(
            backgroundColor: Colors.white,
            body: Scrollbar(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: 600,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                    child: Column(
                      children: [
                        Container(
                          height: 250,
                          width: double.infinity,
                          child: Image.network(
                            snapshot.data,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        aboutFluse(),
                        SizedBox(
                          height: 20,
                        ),
                        developpeurs(),
                        SizedBox(
                          height: 20,
                        ),
                        pourquoiFluse(),
                        SizedBox(
                          height: 20,
                        ),
                        informatique(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Container developpeurs() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Équipe',
            style: TextStyle(
                fontSize: 22,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                color: primary),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            children: [
              Text(
                'Nous sommes une équipe de deux développeurs:',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Didac',
                ),
              ),
              FlatButton(
                child: Text(
                  'Mahamat Naim Abdelkerim',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Poppins',
                      color: Colors.purple[900],
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
              ),
              Text(
                '& ',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Didac',
                ),
              ),
              FlatButton(
                child: Text(
                  'Ali Mahamat Choukou',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Poppins',
                      color: Colors.purple[900],
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
              ),
              Text(
                '.',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Didac',
                ),
              ),
              Text(
                ' Ayant étudié à l\'université Ibn Tofail de Kénitra (Maroc), faculté de science, filière Science Mathématique et Informatique (SMI).',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Didac',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container pourquoiFluse() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pourquoi utiliser Fluse ?',
            style: TextStyle(
                fontSize: 22,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                color: primary),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Nous nous sommes rendus compte que l\'accès aux documents était difficile pour les étudiants, car certains étudiants (notamment les nouveaux) partaient d\'un aîné à un autre à la recherche des anciens cours. Malgré l\'utilisation des plateformes comme Classroom, les profs créaient de "classe" chaque nouvelle année scolaire, ce qui fait que les nouveaux étudiants n\'ont plus accès aux cours de l\'année précédente. De ce fait, Fluse entre en jeu. Afin d\'aider le plus d\'étudiants, nous essayons de fournir la meilleure expérience utilisateur, une navigation facile et des possibilités d\'échange rapide. Juste pour être sûr que vous appréciez d\'utiliser notre service. Si vous pensez que quelque chose pourrait être fait encore mieux, nous sommes toujours ouverts à vos commentaires et suggestions.',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Didac',
            ),
          ),
        ],
      ),
    );
  }

  Container informatique() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vous vous intéressez à la technologie ?',
            style: TextStyle(
                fontSize: 22,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                color: primary),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Notre pile technique est très simple. Nous sommes fans du couple Flutter & Firebase et toujours intéressés par les derniers standards de la technologies du web et mobile.',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Didac',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10.0),
          //   child: SelectableText(
          //     '• Framework: Flutter',
          //     style: TextStyle(
          //         fontSize: 18, fontFamily: 'Didac', color: Colors.black87),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10.0),
          //   child: Text(
          //     '• Les langages informatique : Dart et JavaScript',
          //     style: TextStyle(
          //       fontSize: 18,
          //       fontFamily: 'Didac',
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10.0),
          //   child: Text(
          //     '• Cloud Base de données : Cloud Firebase',
          //     style: TextStyle(
          //       fontSize: 18,
          //       fontFamily: 'Didac',
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10.0),
          //   child: Text(
          //     '• Base de données: Realtime Database (Firebase)',
          //     style: TextStyle(
          //       fontSize: 18,
          //       fontFamily: 'Didac',
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10.0),
          //   child: Text(
          //     '• Stockage: Firebase Storage',
          //     style: TextStyle(
          //       fontSize: 18,
          //       fontFamily: 'Didac',
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget aboutFluse() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'À propos de Fluse',
            style: TextStyle(
                fontSize: 22,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                color: primary),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Fluse qui est une plateforme en ligne qui a pour rôle principal: d’aider les étudiants en leur facilitant l’accès aux cours, aux informations sur les établissements marocains et la mise en relation avec d’autres étudiants à l’aide des forums. Une plateforme faite par des étudiants pour les étudiants.',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Didac',
            ),
          ),
        ],
      ),
    );
  }
}
