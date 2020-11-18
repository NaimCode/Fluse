import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/routes/bottomNavigation.dart';
import 'package:website_university/routes/discussion/discussion.dart';
import 'package:website_university/routes/etablissements/etablissements.dart';
import 'package:website_university/routes/notifications/notifications.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Index pour le navBar
  String selectItemNav = 'Home';
  //Variable pour 'responsive'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //elevation: 20.0,
        backgroundColor: Colors.white,
        title: navBar(),
      ),
      body: Container(
        child: bodyPC(),

        // child: Row(
        //   children: [
        //     Scaffold(
        //       appBar: AppBar(),
        //     )
        //     //nav
        //     //navBar(selectItemNav),
        //     //body

        //     //context.isSmallTablet ? BottomNav() : Container(),
        //   ],
        // ),
      ),
      bottomSheet: !context.isSmallTablet ? BottomNav() : Text(''),
    );
  }

  Row bodyPC() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            child: Notifications(),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            child: Etablissements(),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Discussion(),
          ),
        ),
      ],
    );
  }
  ///////NAV BAR///

  Widget navBar() {
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
                child: Image.asset('logo.png'),
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
                      onPressed: () {
                        setState(() {
                          selectItemNav = 'Etablissements';
                        });
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
              child: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(backgroundImage: AssetImage('avatar.jpg')),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Naim',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.indigo[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications,color: primary),
//             label: 'Notifications',
//           ),

//           BottomNavigationBarItem(
//             icon: Icon(Icons.comment,color: primary),
//             label: 'Discussions',
//           ),
//         ],
//       ),
