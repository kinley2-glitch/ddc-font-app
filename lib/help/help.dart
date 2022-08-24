import 'package:flutter/material.dart';
import 'package:miniprojectclone/help/screenshot.dart';
import 'package:miniprojectclone/help/title.dart';
import 'package:miniprojectclone/provider/state.dart';
import 'package:provider/src/provider.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  final String engStringTitle1 =
      '1.Type in the textarea to check different font';
  final String dzoStringTitle1 =
      '༡༽ཡིག་གཟུགས་མ་འདྲཝ་ཚུ་བལྟ་ནིའི་དོན་ལུ་་ས་སྟོང་ནང་མཛུབ་གནོན་རྐྱབ་གནང།';

  final String engStringTitle2 =
      '2.Press Install button to install specific font on your system.';
  final String dzoStringTitle2 =
      '༢༽ཡིག་གཟུགས་བཙུགས་ནིའི་དོན་ལུ་ བཙུགས་ཟེར་བའི་ ཨེབ་རྟ་གུར་ཨེབ་གནང།';

  final String engStringTitle3 =
      '3.Only for the first time, you have to press “install” twice. This is to give permission for the app to install the font.';
  final String dzoStringTitle3 =
      '༣༽འགོ་དང་པ་ཚར་གཅིག་ བཙུགས་ཟེར་མི་གུར་ ཚར་གཉིས་ཨེབ་དགོ། འདི་ཡང་ ཡིག་གཟུགས་བཙུགས་ནིའི་དོན་ལུ་ གནང་བ་བྱིན་ནིའི་དོན་ལུ་ཨིན།';

  final String engStringTitle4 =
      '4.Go to Settings > General > Font to verify fonts installed.';
  final String dzoStringTitle4 =
      '༤༽གསར་བཙུགས་འབད་ཡོད་པའི་ཡིག་གཟུགས་ཚུ་བལྟ་ནིའི་དོན་ལུ་ Settings>General->font ནང་བལྟ་གནང།';

  final String engStringTitle5 =
      '5.Now, you can use the installed font on other typing apps.';
  final String dzoStringTitle5 =
      '༥༽ད་ཁྱོད་ཀྱིས་ ཡིག་གཟུགས་འདི་ རིམ་ལུགསས་གཞན་ཚུ་ནང་ཡང་ལག་ལེན་འཐབ་ཚུགས།';

  final String engStringTitle6 =
      '6.Press the Uninstall button if you want to remove the installed fonts.';
  final String dzoStringTitle6 =
      '༦༽བཏོན་གཏང་ནིའི་དོན་ལུ་ བཏོན་གཏང་ཟེར་བའི་ཨེབ་རྟ་གུར་ཨེབ་གནང།';

  final String engStringTitle7 = """NOTE:
    
     * In general web-apps do not communicate with the iPhone system so they do not have access to the installed fonts so it is not supported there.
     
     * In general Native apps have access to the system so they have access to the system, so they are supported
     
     Support apps list (not exhaustive):
     - OneDoc
     - Word""";
  final String dzoStringTitle7 = '''དྲན་ཐོ།

སྤྱིར་བཏང་ལུ་ ཡོངས་འབྲེལ་རིམ་ལུགས་ཚུ་གིས་  ལག་ལེན་་རིམ་ལུགས་དང་འབྲེལ་བ་འཐབ་མི་ཚུགས་དོ་ཡོདཔ་ལས་ ཡིག་གཟུགས་ཡང་ལཱ་འབད་མི་བཏུབ་དོ་ཡོདཔ་ཨིན།

སྤྱིར་བཏང་ལུ་ native རིམ་ལུགས་ཀྱིས་ ལག་ལེན་རིམ་ལུགས་དང་འབྲེལ་བ་འཐབ་ཚུགས་དོ་ཡོདཔ་ལས་ ཡིག་གཟུགས་ཡང་ལཱ་འབད་མི་བཏུབ་དོ་ཡོདཔ་ཨིན།

ཡིག་གཟུགས་ལཱ་འབད་བཏུབ་པའི་རིམ་ལུགས།
-OneDoc
-Word
''';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    TitleText(
                        engText: engStringTitle1, dzoText: dzoStringTitle1),
                    ShowScreenshot(imagePath: "assets/images/1-dummy.png"),
                    SizedBox(height: 30),
                    TitleText(
                        engText: engStringTitle2, dzoText: dzoStringTitle2),
                    ShowScreenshot(
                      imagePath: context.watch<EnglishState>().english
                          ? "assets/images/2-en.png"
                          : "assets/images/2-dz.png",
                    ),
                    SizedBox(height: 30),
                    TitleText(
                        engText: engStringTitle3, dzoText: dzoStringTitle3),
                    ShowScreenshot(
                      imagePath: context.watch<EnglishState>().english
                          ? "assets/images/3-en.png"
                          : "assets/images/3-dz.png",
                    ),
                    SizedBox(height: 30),
                    TitleText(
                        engText: engStringTitle4, dzoText: dzoStringTitle4),
                    ShowScreenshot(imagePath: "assets/images/4.png"),
                    SizedBox(height: 30),
                    TitleText(
                        engText: engStringTitle5, dzoText: dzoStringTitle5),
                    // ShowScreenshot(imagePath: "assets/images/1.png"),
                    SizedBox(height: 30),
                    TitleText(
                        engText: engStringTitle6, dzoText: dzoStringTitle6),
                    ShowScreenshot(
                      imagePath: context.watch<EnglishState>().english
                          ? "assets/images/6-en.jpeg"
                          : "assets/images/6-dz.jpeg",
                    ),
                    SizedBox(height: 30),
                    TitleText(
                        engText: engStringTitle7, dzoText: dzoStringTitle7),
                    SizedBox(height: 30),
                  ])),
        ),
      ),
    );
  }
}
