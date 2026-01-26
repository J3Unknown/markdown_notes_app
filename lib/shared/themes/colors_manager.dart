import 'dart:ui';

enum Accents{
  dark,
  light,
  red,
  orange,
  blue,
  green,
  yellow,
  rose,
}

class ColorsManager{
  static const Color lightThemeBackgroundColor = Color(0xfffdfcfd);
  static const Color darkThemeBackgroundColor = Color(0xff000000);
  static const Color darkThemePrimaryColor = Color(0xff171717);
  static const Color lightThemePrimaryColor = Color(0xfff4f4f4);
  static const Color darkThemeSecondaryColor = Color(0xff5c5c5c);
  static const Color gray = Color(0xff454545);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);
  static const Color red = Color(0xffF44336);
  static const Color transparent = Color(0x00000000);
}

Color getAccentColor(Accents acc){
  switch(acc){
    case Accents.dark:
      return Color(0xffdddada);
    case Accents.light:
      return Color(0xff1c1c1c);
    case Accents.red:
      return Color(0xffF44336);
    case Accents.orange:
      return Color(0xffFF9800);
    case Accents.blue:
      return Color(0xff2196F3);
    case Accents.green:
      return Color(0xff4CAF50);
    case Accents.yellow:
      return Color(0xffFFEB3B);
    case Accents.rose:
      return Color(0xffe276ff);
  }
}