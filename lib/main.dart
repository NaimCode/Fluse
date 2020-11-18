import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_university/routes/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ibn Tofail',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
