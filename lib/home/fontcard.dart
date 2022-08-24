import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miniprojectclone/provider/state.dart';
import 'package:provider/src/provider.dart';

class FontCard extends StatefulWidget {
  FontCard(
      {Key? key,
      required this.fontName,
      required this.isFontInstalled,
      required this.installText})
      : super(key: key);
  final String fontName;
  bool isFontInstalled;
  String installText;

  @override
  State<FontCard> createState() => _FontCardState();
}

class _FontCardState extends State<FontCard> {
  // The channel that flutter will talk with native IOS
  static const MethodChannel methodChannelInstallFont =
      MethodChannel("DDC.fontapp.com/installFont");

  // Calls the install font on the native side
  Future<void> _installFont() async {
    try {
      // print("Installing");
      //Invoking the method on the Native Side and passing the fontName as the argument since the Native side needs to know which one to install.
      final bool? result = await methodChannelInstallFont.invokeMethod(
          "installFont", widget.fontName);
    } on PlatformException {
      print("Flutter: Failed installing on the Native Side");
    }
  }

  // Calls the uninstall font on the native side
  Future<void> _uninstallFont() async {
    try {
      // print("Uninstalling");
      //Invoking the method on the Native Side and passing the fontName as the argument since the Native side needs to know which one to install.
      final bool? result = await methodChannelInstallFont.invokeMethod(
          "uninstallFont", widget.fontName);
    } on PlatformException {
      print("Flutter: Failed uninstalling on the Native Side");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Card(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.watch<EnglishState>().english
                              ? widget.fontName
                              : chagetoDzongkha(widget.fontName),
                          style: TextStyle(
                              fontSize: 20, fontFamily: widget.fontName),
                        ),
                        widget.isFontInstalled
                            ? Icon(
                                Icons.verified_sharp,
                                color: Colors.green,
                              )
                            : Text(''),
                      ]),
                  ElevatedButton(
                      child: Text(context.watch<EnglishState>().english
                          ? "${widget.isFontInstalled ? "Uninstall" : "Install"}"
                          : "${widget.isFontInstalled ? "བཏོན་བཏང།" : "བཙུགས།"}"),
                      onPressed: () {
                        //_showDialog(context);
                        _showIOSStyleDialog(context);
                      },
                      // child: isFontInstalled ? Text("Uninstall") : Text("Install") ,
                      style: widget.isFontInstalled
                          ? ElevatedButton.styleFrom(
                              // Button color if the text is "Uninstall"
                              minimumSize: const Size(100, 50),
                              primary: Colors.white,
                              onPrimary: Colors.black,
                              side: BorderSide(
                                  width: 2.0, color: Color(0xffFF7717)))
                          : ElevatedButton.styleFrom(
                              // Button color if the text is "Install"
                              minimumSize: const Size(100, 50),
                              primary: Color(0xffF58F00),
                            )),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  initialValue:
                      "འ་ནཱི་ཡིག་གཟུགས་འདི་ DDC ${widget.fontName} ཨིན། འདི་དགའ་བ་ཅིན་ ཁྱོད་རའི་འགྲུལ་འཕྲིན་ནང་བཙུགས་ཏེ་ ལག་ལེན་འཐབ་གནང་། \nThis is DDC ${widget.fontName} font. Install and use it in your phone if you like it. ",
                  minLines: 3,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(height: 2, fontFamily: widget.fontName),
                  decoration: InputDecoration(border: InputBorder.none),
                ))
          ],
        ),
      ),
    );
  }

  // The function to implement pop-up for user cofirmation.
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
              "${widget.isFontInstalled ? context.watch<EnglishState>().english ? "Uninstall" : "མ་བཙུགས" : context.watch<EnglishState>().english ? "Install" : "བཙུགས།"} ${context.watch<EnglishState>().english ? widget.fontName : chagetoDzongkha(widget.fontName)}?"),
          content: new Text(context.watch<EnglishState>().english
              ? "Are you sure you want to ${widget.isFontInstalled ? "Uninstall" : "Install"} ${widget.fontName}?"
              : "${chagetoDzongkha(widget.fontName)} ཐད་རི་བ་རི་${widget.isFontInstalled ? "བཏོན་གཏང་ག?" : "བཙུགས་ནི་ཨིན་ན?"}"),
          actions: <Widget>[
            new TextButton(
              child: new Text(context.watch<EnglishState>().english
                  ? "Cancle"
                  : "བཏོན་བཏང།"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                  "${widget.isFontInstalled ? context.watch<EnglishState>().english ? "Uninstall" : "བཏོན་བཏང།" : context.watch<EnglishState>().english ? "Install" : "བཙུགས།"}"),
              onPressed: () {
                if (widget.installText == "Install" ||
                    widget.installText == "བཙུགས།") {
                  _installFont();
                } else if (widget.installText == "Uninstall" ||
                    widget.installText == "མ་བཙུགས།") {
                  // else, if it is "Uninstall", call the uninstall Font function
                  _uninstallFont();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Show IPhone Style Dialog
  void _showIOSStyleDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: new Text(
              "${widget.isFontInstalled ? context.watch<EnglishState>().english ? "Uninstall" : "བཏོན་བཏང་" : context.watch<EnglishState>().english ? "Install" : "བཙུགས་"} ${context.watch<EnglishState>().english ? widget.fontName : chagetoDzongkha(widget.fontName).replaceAll("།", "")}?"),
          content: new Text(context.watch<EnglishState>().english
              ? "Are you sure you want to ${widget.isFontInstalled ? "Uninstall" : "Install"} ${widget.fontName}?"
              : "${chagetoDzongkha(widget.fontName).replaceAll("།", "་")} ཐད་རི་བ་རི་${widget.isFontInstalled ? "བཏོན་གཏང་ག?" : "བཙུགས་ནི་ཨིན་ན?"}"),
          actions: <Widget>[
            new TextButton(
              child: new Text(context.watch<EnglishState>().english
                  ? "Don't ${widget.isFontInstalled ? "Uninstall" : "Install"}"
                  : "${widget.isFontInstalled ? "བཏོན་མ་གཏང།" : "མ་བཙུགས།"}"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new TextButton(
              child: new Text(
                  "${widget.isFontInstalled ? context.watch<EnglishState>().english ? "Uninstall" : "བཏོན་གཏང།" : context.watch<EnglishState>().english ? "Install" : "བཙུགས།"}"),
              onPressed: () {
                if (widget.installText == "Install" ||
                    widget.installText == "བཙུགས།") {
                  _installFont();
                } else if (widget.installText == "Uninstall" ||
                    widget.installText == "བཏོན་བཏང།") {
                  // else, if it is "Uninstall", call the uninstall Font function
                  _uninstallFont();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String chagetoDzongkha(fontname) {
    switch (fontname) {
      case "Jomolhari":
        return "ཇོ་མོ་ལྷ་རི།";
      case "Joyig":
        return "མགྱོགས་ཡིག།";
      case "Uchen":
        return "དབུ་ཅན།";
      default:
        return fontname;
    }
  }
}
