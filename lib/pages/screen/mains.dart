import 'package:finalpdf/pages/convert/convertDes.dart';
import 'package:finalpdf/pages/encrypt/encrypt.dart';
import 'package:finalpdf/pages/home/body.dart';
import 'package:finalpdf/pages/setting/settings.dart';
import 'package:finalpdf/widgets/constant.dart';
import 'package:finalpdf/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  __MainScreenState createState() => __MainScreenState();
}

class __MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _radiusAnimation;

  @override
  void initState(){
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3),)..forward();
    _rotationAnimation = Tween(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

      _radiusAnimation = Tween(begin: 450.0, end: 10.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

      _controller.addListener(() {
        setState(() {
        });
      });
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }else if (status == AnimationStatus.dismissed){
          _controller.forward();
        }
      });
  }

  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
      Column(
        children: <Widget>[
          Container(
            child: SmartPDF(),
          ),
          Expanded(child: Oofs()),
          Expanded(child: Buton())
        ],
      ),
      Column(
        children: <Widget>[
          Container(
            child: ConvertPage(),
          ),
          Expanded(child: Conv()),
          Expanded(child: Con())
        ],
      ),
      Column(
        children: <Widget>[
          Container(
            child: EncryptHeader(),
          ),
          Expanded(child: EncryptPage()),
          // Expanded(child: Con())
        ],
      ),
      Column(
        children: <Widget>[
          Container(
            child: SettingPage(),
          ),
          Expanded(child: SettingMain()),
        ],
      ),
  ];
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChange>(context).themeMode == ThemeMode.light;
    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar:
      BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.document_scanner_outlined), label: "Convert"),
          BottomNavigationBarItem(icon: Icon(Icons.enhanced_encryption_outlined), label: "Encrypt"),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: "Setting"),
        ],
      )
      );
  }
}