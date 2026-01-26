import 'package:flutter/material.dart';
import 'package:package_tester/shared/themes/colors_manager.dart';
import 'package:package_tester/shared/themes/themes_manager.dart';
import 'package:package_tester/shared/util/components.dart';
import 'package:package_tester/shared/util/icons_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  late Color color;
  late ThemesManager themesManager;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    getSharedPrefInstance();
    color = ThemesManager.accent;
  }

  getSharedPrefInstance() async{
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final themesManager = Provider.of<ThemesManager>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: ColorsManager.black.withValues(alpha: 0.2), blurRadius: 5, offset: Offset(5, 5))
                ],
                color: ThemesManager.isDark?ColorsManager.darkThemePrimaryColor:ColorsManager.lightThemePrimaryColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Theme', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),),
                      Spacer(),
                      IconButton(onPressed: () => themesManager.toggleTheme(), icon: Icon(ThemesManager.isDark?IconsManager.darkThemeIcon:IconsManager.lightThemeIcon, color: (color == getAccentColor(Accents.light) || color == getAccentColor(Accents.dark))?(ThemesManager.isDark?ColorsManager.white:ColorsManager.black):color,))
                    ],
                  ),
                  Divider(color: Theme.of(context).primaryColor.withValues(alpha: 0.4),),
                  Text('Accent', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),),
                  Wrap(
                    spacing: 10,
                    runSpacing: 5,
                    children: [
                      buildChipChoice(
                        ThemesManager.isDark?Accents.dark:Accents.light,
                        'Default',
                        color == (ThemesManager.isDark?getAccentColor(Accents.dark):getAccentColor(Accents.light)),
                        (value){
                          setState(() {
                            color = ThemesManager.isDark?getAccentColor(Accents.dark):getAccentColor(Accents.light);
                            themesManager.setAccent(ThemesManager.isDark?Accents.dark:Accents.light);
                          });
                          prefs.setInt('Accent', color.value);
                        },
                        isTextReverted: true
                      ),
                      buildChipChoice(
                        Accents.rose,
                        'Rose',
                        color == getAccentColor(Accents.rose),
                        (value){
                          setState(() {
                            color = getAccentColor(Accents.rose);
                            themesManager.setAccent(Accents.rose);
                          });
                          prefs.setInt('Accent', color.value);
                        },
                      ),
                      buildChipChoice(
                        Accents.yellow,
                        'Yellow',
                        color == getAccentColor(Accents.yellow),
                        (value){
                          setState(() {
                            color = getAccentColor(Accents.yellow);
                            themesManager.setAccent(Accents.yellow);
                          });
                          prefs.setInt('Accent', color.value);
                        },
                      ),
                      buildChipChoice(
                        Accents.green,
                        'Green',
                        color == getAccentColor(Accents.green),
                        (value){
                          setState(() {
                            color = getAccentColor(Accents.green);
                            themesManager.setAccent(Accents.green);
                          });
                          prefs.setInt('Accent', color.value);
                        },
                      ),
                      buildChipChoice(
                        Accents.blue,
                        'Blue',
                        color == getAccentColor(Accents.blue),
                        (value){
                          setState(() {
                            color = getAccentColor(Accents.blue);
                            themesManager.setAccent(Accents.blue);
                          });
                          prefs.setInt('Accent', color.value);
                        },
                      ),
                      buildChipChoice(
                        Accents.orange,
                        'Orange',
                        color == getAccentColor(Accents.orange),
                        (value){
                          setState(() {
                            color = getAccentColor(Accents.orange);
                            themesManager.setAccent(Accents.orange);
                          });
                            prefs.setInt('Accent', color.value);
                        },
                      ),
                      buildChipChoice(
                        Accents.red,
                        'Red',
                        color == getAccentColor(Accents.red),
                        (value){
                          setState(() {
                            color = getAccentColor(Accents.red);
                            themesManager.setAccent(Accents.red);
                            prefs.setString('Accent', color.colorSpace.toString());
                          });
                        },
                      )
                    ],
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
