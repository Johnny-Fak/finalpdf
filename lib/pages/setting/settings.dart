import 'package:finalpdf/widgets/constant.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:provider/provider.dart';

class ThemeChange extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeChange>(context);
    return Switch.adaptive(
      value: themeChange.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeChange>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 80, 20, 10),
      child: Column(
        children: const <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Settings ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // color: headerColor,
                fontSize: 30,
              ),
            ),
          ),
          Divider(
            color: lineColor,
            height: 50,
            thickness: 2,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'P R E F E R E N C E S',
              style: TextStyle(
                color: subTxt,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingMain extends StatelessWidget {
  const SettingMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 30, 20, 40),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: const <Widget>[
                Icon(
                  Icons.settings_outlined,
                  size: 22,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Dark Mode',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // color: headerColor,
                      fontSize: 16),
                ),
                Spacer(),
                ChangeTheme()
              ],
            ),
          )
        ],
      ),
    );
  }
}
