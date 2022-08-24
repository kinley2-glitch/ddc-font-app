import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:miniprojectclone/about/about.dart';
import 'package:miniprojectclone/help/help.dart';
import 'package:miniprojectclone/home/home.dart';
import 'package:miniprojectclone/provider/state.dart';
import 'package:provider/src/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:share/share.dart';

/// This is the main application widget.
class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MyStatefulWidget(),
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        defaultScaleFactor: MediaQuery.of(context).size.shortestSide > 500
            ? MediaQuery.of(context).size.shortestSide * 0.00175
            : 1,
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MyApp(),
    Help(),
    About(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _controller = ValueNotifier<bool>(true);
  bool _checked = true;

// ...
  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
          context.read<EnglishState>().changestate();
          _checked = true;
        } else {
          context.read<EnglishState>().changestate();
          _checked = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<EnglishState>().english
            ? "   Dzongkha Font"
            : "   རྫོང་ཁའི་ཡིག་གཟུགས།"),
        backgroundColor: Color(0xffFF5A1F),
        actions: [
          Container(
            height: 5,
            width: 85,
            padding: EdgeInsets.fromLTRB(7, 10, 7, 10),
            child: AdvancedSwitch(
              controller: _controller,
              activeColor: Color(0xffFF7717),
              inactiveColor: Color(0xffFF870A),
              activeChild: Text('རྫོང་ཁ།'),
              inactiveChild: Text('ENG'),
              borderRadius: BorderRadius.all(const Radius.circular(15)),
              width: 65.0,
              height: 30.0,
              enabled: true,
              disabledOpacity: 1,
            ),
          ),
          Center(
            child: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(
                  "Download DDC app from: www.playstore.com/DDC Font App",
                  subject: 'Dzongkha Development Comission',
                );
              },
            ),
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Color(0xffFF7717),
            ),
            label: context.watch<EnglishState>().english ? 'Home' : "གདོང་ཤོག།",
            backgroundColor: Color(0xffFF7717),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.help_outline_outlined,
              color: Color(0xffFF7717),
            ),
            label: context.watch<EnglishState>().english ? 'Help' : "གྲོགས་རམ།",
            backgroundColor: Color(0xffFF7717),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box_outlined,
              color: Color(0xffFF7717),
            ),
            label: context.watch<EnglishState>().english ? 'About' : "སྐོར་ལས།",
            backgroundColor: Color(0xffFF7717),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xffFF7717),
        onTap: _onItemTapped,
      ),
    );
  }
}
