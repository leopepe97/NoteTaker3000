import 'package:flutter/material.dart';
import 'package:note_taker_3000/ui/custom_colors.dart';
import 'package:note_taker_3000/ui/home_route.dart';

void main() {
  runApp(NoteTaker3000());
}

class NoteTaker3000 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: CustomColors.primaryBlack,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeRoute(),
    );
  }
}