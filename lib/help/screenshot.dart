import 'package:flutter/cupertino.dart';

class ShowScreenshot extends StatelessWidget {
  const ShowScreenshot({Key? key, required String this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: 300,
      child: Image.asset(imagePath),
    );
  }
}
