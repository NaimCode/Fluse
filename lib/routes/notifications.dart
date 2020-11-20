import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:website_university/constantes/model.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Information> listNotifications;

  @override
  void initState() {
    listNotifications = listInfo;
    super.initState();
  }

  double elevationCard = 2.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backColor,
        //check
        title: Icon(
          Icons.notifications,
          size: 35,
          color: primary,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        color: backColor,
        child: ListView.builder(
            itemCount: listNotifications.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        userSection(index),
                        contentSection(index),
                        dateSection(index)
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Container dateSection(int index) {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        listNotifications[index].date,
        style: TextStyle(fontFamily: 'Ubuntu', fontSize: 10),
      ),
    );
  }

  Container contentSection(int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            //                    <--- top side
            color: backColor,

            width: 1.0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Text(
            listNotifications[index].description,
            style: TextStyle(fontFamily: 'Ubuntu'),
          ),
          SizedBox(
            height: 10.0,
          ),
          FlatButton.icon(
            color: primary,
            onPressed: () {},
            icon: Icon(
              Icons.article,
              color: Colors.white,
            ),
            label: Text(
              'Afficher',
              style: TextStyle(
                  fontFamily: 'Didac', color: Colors.white,),
            ),
          )
        ],
      ),
    );
  }

  Container userSection(int index) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            //                    <--- top side
            color: backColor,

            width: 1.0,
          ),
        ),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage(listNotifications[index].user.image),
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                listNotifications[index].user.nom,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
          Icon(
            Icons.star_purple500_outlined,
            color: Colors.amber,
            size: 20,
          )
        ],
      ),
    );
  }
}
