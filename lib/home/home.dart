import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miniprojectclone/home/fontcard.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static var fromIOSMethodChannelName =
      MethodChannel("com.ddc.font/Notification");

  String listFromIOS = '';
  bool isJomolhariInstalled = true;
  String jomolhariInstallText = "";
  bool isJoyigInstalled = true;
  String joyigInstallText = "";
  bool isUchenInstalled = true;
  String uchenInstallText = "";

  Future<void> _fontInstallNotify(MethodCall call) async {
    listFromIOS = call.arguments;
    // print("List: $listFromIOS");
    switch (call.method) {
      case "fontInstallNotify":
        updateFontStatus(listFromIOS);
        return;
      default:
        print("Not Implemented");
    }
  }

  Future<void> updateFontInstallState() async {
    const MethodChannel methodChannelInstallFont =
        MethodChannel("DDC.fontapp.com/installFont");

    try {
      // print("Installing");
      //Invoking the method on the Native Side and passing the fontName as the argument since the Native side needs to know which one to install.
      final String? listOfFontsFromIOS =
          await methodChannelInstallFont.invokeMethod("getFonts");
      // print("Result is ${listOfFontsFromIOS}");
      updateFontStatus(listOfFontsFromIOS!);
    } on Exception {
      print("Failed to get fonts");
    }
  }

  // Called when the widget tree is being built - we can update the status of the installed fonts using this function.
  @override
  void initState() {
    updateFontInstallState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fromIOSMethodChannelName.setMethodCallHandler(_fontInstallNotify);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          // To dismiss the keyboard after the user is done testing with the font.
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            height: double.maxFinite,
            color: Color(0xffFFDDAD),
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  /* !!! IMPORTANT !!! ================================================
                *  These font names (Case sensitive) are passed down to the Native IOS side
                *  as the font Resource there is named exactly as they are here
                *  if you are planning to change them, update the resource name on the Native IOS side too*/
                  FontCard(
                      fontName: "Jomolhari",
                      isFontInstalled: isJomolhariInstalled,
                      installText: jomolhariInstallText),
                  FontCard(
                      fontName: "Joyig",
                      isFontInstalled: isJoyigInstalled,
                      installText: joyigInstallText),
                  FontCard(
                      fontName: "Uchen",
                      isFontInstalled: isUchenInstalled,
                      installText: uchenInstallText),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateFontStatus(String listFromIOS) {
    // print("List from ios$listFromIOS");
    if (listFromIOS.contains("Jomolhari")) {
      // Yes Jomolhari
      print("Yes Jomolhari");
      setState(() {
        isJomolhariInstalled = true;
        jomolhariInstallText = "Uninstall";
      });
    } else {
      // No Jomolhari
      print("No Jomolhari");
      setState(() {
        isJomolhariInstalled = false;
        jomolhariInstallText = "Install";
      });
    }

    if (listFromIOS.contains("DDC_Joyig")) {
      // Yes Joyig
      print("Yes Joyig");
      setState(() {
        isJoyigInstalled = true;
        joyigInstallText = "Uninstall";
      });
    } else {
      // No Joyig
      print("No Joyig");
      setState(() {
        isJoyigInstalled = false;
        joyigInstallText = "Install";
      });
    }

    if (listFromIOS.contains("DDC_Uchen")) {
      // Yes Uchen
      print("Yes Uchen");
      setState(() {
        isUchenInstalled = true;
        uchenInstallText = "Uninstall";
      });
    } else {
      // NO UChen
      print("No Uchen");
      setState(() {
        isUchenInstalled = false;
        uchenInstallText = "Install";
      });
    }
  }

  String chagetoDzongkha(installText) {
    switch (installText) {
      case "Install":
        return "བཙུགས།";
      case "Uninstall":
        return "བཏོན་གཏང།";
      default:
        return installText;
    }
  }
}
