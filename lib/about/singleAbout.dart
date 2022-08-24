import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection(
      {Key? key,
      required this.title,
      required this.content,
      required this.imgurl})
      : super(key: key);

  final String title;
  final String content;
  final String imgurl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            color: Colors.orangeAccent,
            padding: EdgeInsets.all(10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
              color: Colors.white,
              width: double.maxFinite,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Image.asset(
                      imgurl,
                      height: 100,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        content,
                        style: TextStyle(
                            fontSize: 18, height: 1.5, fontFamily: "Jomolhari"),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
