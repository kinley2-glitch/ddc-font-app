import 'package:flutter/material.dart';
import 'package:miniprojectclone/provider/state.dart';
import 'package:provider/src/provider.dart';

class TitleText extends StatelessWidget {
  const TitleText({Key? key, required this.dzoText, required this.engText})
      : super(key: key);

  final String dzoText;
  final String engText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(10),
      color: Colors.orangeAccent,
      child: Text(
        context.watch<EnglishState>().english ? engText : dzoText,
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
