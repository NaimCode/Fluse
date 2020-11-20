import 'dart:html';

import 'package:flutter/material.dart';
import 'package:website_university/constantes/couleur.dart';
import 'package:get/get.dart';
import 'package:website_university/routes/discussion.dart';
import 'package:website_university/routes/notifications.dart';

bottomNav() {
  return Container(
    alignment: Alignment.bottomCenter,
    child: Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  //                    <--- top side
                  color: backColor,
                  width: 2.0,
                ),
              ),
            ),
            child: FlatButton(
              onPressed: () {
                Get.to(Notifications(true));
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.notifications,
                  color: primary,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(
                  color: backColor,
                  width: 2.0,
                ),
                top: BorderSide(
                  //                    <--- top side
                  color: backColor,
                  width: 2.0,
                ),
              ),
            ),
            child: FlatButton(
              onPressed: () {
                Get.to(Discussion(true));
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.comment,
                  color: primary,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
