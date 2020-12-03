import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/model.dart';
import 'package:website_university/constantes/widget.dart';
import 'package:website_university/main.dart';
import 'package:website_university/routes/bottomNavigation.dart';
import 'package:website_university/routes/discussion.dart';
import 'package:website_university/routes/pages/accueil.dart';
import 'package:website_university/routes/pages/ajoutEtablissement.dart';
import 'package:website_university/routes/pages/ajoutdocument.dart';
import 'package:website_university/routes/pages/contact.dart';
import 'package:website_university/routes/pages/documents.dart';
import 'package:website_university/routes/pages/etablissements.dart';
import 'package:website_university/routes/notifications.dart';
import 'package:website_university/routes/pages/support.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:website_university/routes/profile.dart';
import 'package:website_university/services/authentification.dart';
import 'package:website_university/services/firestorage.dart';
import 'package:website_university/services/variableStatic.dart';

//import '../main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  ////Fluse

  Animation animation;
  AnimationController animationController;
  bool addClose = true;
  double add = 0.0;
  /////User//////////
  Utilisateur user;

  //Index pour le navBar
  String selectItemNav = 'Profile';

  //Variable pour 'responsive'

  Widget selectBody(String body) {
    switch (body) {
      case 'Home':
        return Accueil();

        break;
      case 'Etablissements':
        return Etablissements();

        break;
      case 'Contact':
        return Contact();

        break;
      case 'Support':
        return Support();

        break;
      case 'Documents':
        return Documents();

        break;
      case 'Profile':
        return Profile();

        break;
      default:
        return Center(
          child: Text('Erreur'),
        );
    }
  }

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    user = context.watch<Utilisateur>();
    return Scaffold(
      appBar: AppBar(
        //elevation: 20.0,

        backgroundColor: Colors.white,
        title: (MediaQuery.of(context).size.width >= 930)
            ? navBarPC()
            : navBarMobile(),
        actions: [
          (MediaQuery.of(context).size.width <= 930)
              ? Builder(
                  builder: (context) => IconButton(
                    alignment: Alignment.center,
                    icon: Icon(
                      Icons.menu,
                      size: 35,
                    ),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip: 'Menu',
                  ),
                )
              : Container(),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Container(child: bodyPC())),
            (MediaQuery.of(context).size.width >= 810)
                ? Container()
                : bottomNav(user),
          ],
        ),
      ),
      endDrawer:
          (MediaQuery.of(context).size.width <= 940) ? menuMobile() : null,
      floatingActionButton: user.admin ? ajout() : null,
    );
  }

  Container ajout() {
    return Container(
      margin: EdgeInsets.only(left: 30.0),
      alignment: Alignment.bottomCenter,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: (Get.width <= 359)
                  ? EdgeInsets.only(left: 0.0)
                  : EdgeInsets.only(left: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInToLinear,
                      height: add,
                      child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: primary,
                        icon: Icon(Icons.article, color: Colors.white),
                        label: Text(
                          'Document',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Get.to(AjoutDocument(user));
                        },
                      )),
                  SizedBox(
                    width: (Get.width <= 362) ? 0.0 : 30,
                  ),
                  AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInToLinear,
                      height: add,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: primary,
                          icon: Icon(Icons.school, color: Colors.white),
                          label: Text(
                            'Etablissement',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Get.to(AjoutEtablissement());
                          },
                        ),
                      )),
                ],
              ),
            ),
            Tooltip(
              message: 'Ajouter un document ou un établissement',
              child: FloatingActionButton(
                onPressed: () {
                  addClose = !addClose;
                  setState(() {
                    (add == 0.0) ? add = 30.0 : add = 0.0;
                  });
                },
                child: Icon(
                  (add == 0.0) ? Icons.add : Icons.close,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Drawer menuMobile() {
    return Drawer(
      semanticLabel: 'Menu',
      child: Container(
        child: Column(
          children: [
            Container(
              height: 300,
              margin: EdgeInsets.only(bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Image.network(
                        user.image,
                        fit: BoxFit.fill,
                        height: 300,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: primary,
                    child: Center(
                      child: Text(
                        '${user.nom}',
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            color: Colors.white,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: ListView.builder(
                  itemCount: listMenu.length,
                  itemBuilder: (context, index) {
                    return Material(
                      child: InkWell(
                        // onHover: (hover) {
                        //   setState(() {
                        //     hover ? elevation = 20 : elevation = 0.0;
                        //   });
                        // },
                        onTap: () {
                          setState(() {
                            selectItemNav = listMenu[index];
                          });
                          Navigator.pop(context);
                        },
                        child: Card(
                          elevation: 0.0,
                          color: Colors.grey[900].withOpacity(0.0),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                              child: (listMenu[index] != 'Home')
                                  ? Text(
                                      listMenu[index],
                                      style: TextStyle(
                                          fontFamily: 'Ubuntu', fontSize: 20.0),
                                    )
                                  : Icon(Icons.home,
                                      color: primary, size: 35.0),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row bodyPC() {
    return Row(
      children: [
        (MediaQuery.of(context).size.width >= 810)
            ? Expanded(
                flex: 2,
                child: Container(
                  child: Notifications(false, user),
                ),
              )
            : Container(
                height: 0.0,
              ),
        Expanded(
          flex: 5,
          child: Container(
            child: selectBody(selectItemNav),
          ),
        ),
        (MediaQuery.of(context).size.width >= 810)
            ? Expanded(
                flex: 2,
                child: Container(
                  child: Discussion(false, user),
                ),
              )
            : Container(height: 0.0),
      ],
    );
  }
  ///////NAV BAR///

  Widget navBarPC() {
    return Container(
      height: 57.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Expanded(
            flex: 1,
            child: Container(
              child: Center(
                child: Image.network(logo),
              ),
            ),
          ),
          //menu
          Expanded(
            flex: 3,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Etablissement
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: (selectItemNav == 'Etablissements')
                              ? Colors.black
                              : Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                    height: double.infinity,
                    child: FlatButton(
                      //Recharge la page
                      onPressed: () {
                        setState(() => selectItemNav = 'Etablissements');
                      },
                      child: Text(
                        'Etablissements',
                        style: TextStyle(fontFamily: 'Ubuntu', fontSize: 20.0),
                      ),
                    ),
                  ),
                  //Documents
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: (selectItemNav == 'Documents')
                              ? Colors.black
                              : Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                    height: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          selectItemNav = 'Documents';
                        });
                      },
                      child: Text(
                        'Documents',
                        style: TextStyle(fontFamily: 'Ubuntu', fontSize: 20.0),
                      ),
                    ),
                  ),
                  //Home
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: (selectItemNav == 'Home')
                              ? Colors.black
                              : Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                    height: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          selectItemNav = 'Home';
                        });
                      },
                      child: Icon(Icons.home, color: primary, size: 35.0),
                    ),
                  ),
                  //Contact
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: (selectItemNav == 'Contact')
                              ? Colors.black
                              : Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                    height: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          selectItemNav = 'Contact';
                        });
                      },
                      child: Text(
                        'Contact',
                        style: TextStyle(fontFamily: 'Ubuntu', fontSize: 20.0),
                      ),
                    ),
                  ),
                  //Support
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          color: (selectItemNav == 'Support')
                              ? Colors.black
                              : Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                    height: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          selectItemNav = 'Support';
                        });
                      },
                      child: Text(
                        'Support',
                        style: TextStyle(fontFamily: 'Ubuntu', fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //profile
          Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              child: popMenu(Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(user.image)),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    user.nom,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.purple[900],
                    ),
                  ),
                ],
              )),
            ),
          )
        ],
      ),
    );
  }

  Widget navBarMobile() {
    return Container(
      height: 57.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Expanded(
            flex: 1,
            child: Container(
              child: Center(child: Image.network(logo)),
            ),
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  //                    <--- top side
                  color: Colors.black,

                  width: 2.0,
                ),
              ),
            ),
            height: double.infinity,
            child: Center(
              child: (selectItemNav != 'Home')
                  ? Text(
                      selectItemNav,
                      style: TextStyle(fontFamily: 'Ubuntu', fontSize: 20.0),
                    )
                  : Icon(Icons.home, color: primary, size: 35.0),
            ),
          ),
          Spacer(),
          //profile
          Expanded(
            flex: 1,
            child: popMenu(
              Container(
                height: double.infinity,
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.image),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget popMenu(Widget profile) {
    return PopupMenuButton(
        tooltip: 'Plus',
        child: profile,
        onSelected: (value) async {
          switch (value) {
            case 1:
              setState(() {
                selectItemNav = 'Profile';
              });
              break;
            case 3:
              Get.defaultDialog(
                  title: 'Déconnexion',
                  middleText: 'Vous êtes sur point de vous déconnecter !',
                  actions: [
                    FlatButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: Text(
                        'Annuler',
                        style: TextStyle(color: primary, fontFamily: 'Didac'),
                      ),
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    FlatButton(
                      onPressed: () async {
                        Get.back();
                        await Authentification(FirebaseAuth.instance)
                            .deconnection();
                      },
                      child: Text(
                        'Se déconnecter',
                        style:
                            TextStyle(color: Colors.white, fontFamily: 'Didac'),
                      ),
                      color: primary,
                    )
                  ]);
              break;
            default:
          }
        },
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.person),
                      ),
                      Text('Mon compte')
                    ],
                  )),
              PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                          child: Icon(Icons.settings)),
                      Text('Paramètre')
                    ],
                  )),
              PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                          child: Icon(Icons.exit_to_app)),
                      Text('Se déconnecter')
                    ],
                  )),
            ]);
  }
}
