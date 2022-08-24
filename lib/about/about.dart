import 'package:flutter/material.dart';
import 'package:miniprojectclone/provider/state.dart';
import 'package:provider/src/provider.dart';

import 'singleAbout.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AboutSection(
                  title: context.watch<EnglishState>().english
                      ? "Dzongkha Development Commision"
                      : "རྫོང་ཁ་གོང་འཕེལ་ལྷན་ཚོགས།",
                  content: context.watch<EnglishState>().english
                      ? "This Application allows you to install Jomolhari, Joyig and Uchen font so that you can use it in other applications\n \n www.dzongkha.gov.bt \n ddc@dzongkha.gov.bt"
                      : "ཨ་ནཱི་རིམ་ལུགས་ཀྱིས་ ཇོ་མོ་ལྷ་རི་ མགྱོགས་ཡིག་ དང་དབུ་ཅན་ ལ་སོགས་པའི་ཡིག་གཟུགས་ཚུ་ ཁྱོད་རའི་འགྲུལ་འཕྲིན་ནང་བཙུགས་ཚུགསཔ་བཟོཝ་ཨིན། \n \n www.dzongkha.gov.bt \n ddc@dzongkha.gov.bt",
                  imgurl: 'assets/images/logo.png',
                ),
                // AboutSection(
                //   title: context.watch<EnglishState>().english
                //       ? "College of Science and Technology"
                //       : "ཚན་རིག་དང་འཕྲུལ་རིག་མཐོ་རིམ་སློབ་གྲྭ།",
                //   content: context.watch<EnglishState>().english
                //       ? "College of Science and Technology (CST) is the first institute in the country to offer undergraduate degree programmes in engineering under the Royal University of Bhutan.  The college aspires to be a centre of excellence in the field of science and technology-enriched with GNH values by offering quality programmes that are relevant to the need of the job market both within and outside the country."
                //       : "ཐདནཔདཐནཔཐདནཔ",
                //   imgurl: 'assets/images/logo.png',
                // ),
                AboutSection(
                  title: context.watch<EnglishState>().english
                      ? "Developer Team"
                      : "རིམ་ལུགས་བཟོ་མི།",
                  content: context.watch<EnglishState>().english
                      ? "This app was developed by the students of College of Science and Technology along with the guidence and support from the lecturers.\n\nPema Galey (Guide)\nNgawang Samten Pelzang \nKamal Acharya \nKhentshe Dorji \nKinley Rabgay"
                      : "རིམ་ལུགས་འདི་ ལེགས་སྦྱར་བ་ཚུ་གིས་རྒྱབ་སྐྱོར་ཐོག་ལུ་ རིན་ཆེན་ལྡིང་ཚན་རིག་དང་འཕྲུལ་རིག་མཐོ་རིམ་སློབ་གྲྭའི་སློབ་ཕྲུག་ཚུ་གིས་བཟོ་ཡོདཔ་ཨིན།\n\nཔདྨ་དགེ་ལེགས། ལམ་སྟོན་པ།\nང་དབང་བསམ་བརྟན་དཔལ་བཟང།\nཀ་མལ་ ཨ་ཙ་རི་ཡ།\nམཁྱེན་རྩེ་རྡོེ།\nཀུན་ལེགས་རབ་རྒྱལ།",
                  imgurl: 'assets/images/cstlogo.png',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
