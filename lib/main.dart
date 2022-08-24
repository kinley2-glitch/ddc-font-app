import 'package:flutter/material.dart';
import 'package:miniprojectclone/provider/state.dart';
import 'package:miniprojectclone/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EnglishState()),
      ],
      child: Splash(),
    ),
  );
}
