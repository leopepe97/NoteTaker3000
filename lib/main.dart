import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_taker_3000/constants/custom_colors.dart';
import 'package:note_taker_3000/ui/home_route.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: CustomColors.grayPrimaryColor, // navigation bar color
    statusBarColor: CustomColors.grayPrimaryColor, // status bar color
  ));
  runApp(NoteTaker3000());
}

class NoteTaker3000 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: CustomColors.grayMaterialColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeRoute(),
    );
  }
}