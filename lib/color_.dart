import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class color_ {
  // Dark Theme Colors
  static const Color darkBlack = Colors.black;
  static const Color darkWhite = Colors.white;
  static const Color darkBackground = Colors.black87;
  static const Color darkBackground2 = Colors.white12;
  static const Color darkGray = Colors.grey;
  static const Color darkButton = Colors.white24;
  static const Color darkFont = Colors.white70;
  static const Color darkGreyDark = Colors.black12;

  // Light Theme Colors
  static const Color lightBlack = Colors.black;
  static const Color lightWhite = Colors.white;
  static const Color lightBackground = Colors.white;
  static  Color lightBackground2 = Colors.grey[100]!;
  static  Color lightGray = Colors.grey[300]!;
  static const Color lightButton = Colors.blueAccent;
  static const Color lightFont = Colors.black87;
  static  Color lightGreyDark = Colors.grey[500]!;

  static const Color lightBlackOpacity = Color(0x99000000);

  static Color get background =>
      (Theme.of(Get.context!).brightness == Brightness.dark) ? darkBackground : lightBackground;

  static Color get background2 =>
      (Theme.of(Get.context!).brightness == Brightness.dark) ? darkBackground2 : lightBackground2;

  static Color get button =>
      (Theme.of(Get.context!).brightness == Brightness.dark) ? darkButton : lightButton;

  static Color get font =>
      (Theme.of(Get.context!).brightness == Brightness.dark) ? darkFont : lightFont;

  static Color get gray =>
      (Theme.of(Get.context!).brightness == Brightness.dark) ? darkGray : lightGray;

  static Color get black =>
      (Theme.of(Get.context!).brightness == Brightness.dark) ? darkBlack : lightBlack;

  static Color get white =>
      (Theme.of(Get.context!).brightness == Brightness.dark) ? darkWhite : lightWhite;

  static Color get greydark =>
      (Theme.of(Get.context!).brightness == Brightness.dark) ? darkGreyDark : lightGreyDark;
}

toggleTheme() async {
  final prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  if (isDarkMode) {
    Get.changeThemeMode(ThemeMode.light);
    await prefs.setBool('isDarkMode', false);
    print("change to light ");
  } else {
    Get.changeThemeMode(ThemeMode.dark);
    await prefs.setBool('isDarkMode', true);
    print("change to Dark ");
  }
}


class AppColors {
  // Light Theme Colors
  static const Color lightBackground = Colors.white;
  static const Color lightBackground2 = Colors.grey;
  static const Color lightFont = Colors.black;
  static const Color lightFont2 = Colors.black;
  static const Color lightButton = Colors.black26;
  static const Color lightGray = Colors.grey;
  static const Color lightBlack = Colors.black;
  static const Color lightWhite = Colors.white;

  // Dark Theme Colors
  static const Color darkBackground = Colors.black87;
  static const Color darkBackground2 = Colors.white12;
  static const Color darkFont = Colors.white70;
  static const Color darkButton = Colors.white24;
  static const Color darkGray = Colors.grey;
  static const Color darkBlack = Colors.black;
  static const Color darkWhite = Colors.white;

  // Blue Navy Theme Colors
  static const Color blueNavyBackground = Colors.white;
  static const Color blueNavyBackground2 = Color(0xFF6E6EE0);
  static const Color blueNavyFont = Colors.black;
  static const Color blueNavyButton = Color(0xFF0288D1);
  static const Color blueNavyGray = Color(0xFFBABAE5);
  static const Color blueNavyBlack = Colors.black;
  static const Color blueNavyWhite = Colors.white;

  // Golden Theme Colors
  static const Color goldenBackground = Colors.white;
  // static const Color goldenBackground2 = Color(0xFFFFC107);
  static const Color goldenBackground2 = Color(0xFFFFCD3D);
  static const Color goldenFont = Colors.black;
  static const Color goldenFont2 = Colors.white70;
  static const Color goldenButton = Color(0xFFFFA000);
  static const Color goldenGray = Color(0xFFB78B3D);
  static const Color goldenBlack = Colors.black;
  static const Color goldenWhite = Colors.white;

  static Color background(BuildContext context, String theme) {
    switch (theme) {
      case 'dark':
        return darkBackground;
      case 'blueNavy':
        return blueNavyBackground;
      case 'golden':
        return goldenBackground;
      case 'light':
      default:
        return lightBackground;
    }
  }

  static Color background2(BuildContext context, String theme) {
    switch (theme) {
      case 'dark':
        return darkBackground2;
      case 'blueNavy':
        return blueNavyBackground2;
      case 'golden':
        return goldenBackground2;
      case 'light':
      default:
        return lightBackground2;
    }
  }

  static Color font(BuildContext context, String theme) {
    switch (theme) {
      case 'dark':
        return darkFont;
      case 'blueNavy':
        return blueNavyFont;
      case 'golden':
        return goldenFont;
      case 'light':
      default:
        return lightFont;
    }
  }
  static Color fontOnBackground(BuildContext context, String theme) {
    switch (theme) {
      case 'dark':
        return darkFont;
      case 'blueNavy':
        return blueNavyFont;
      case 'golden':
        return goldenFont;
      case 'light':
      default:
        return lightFont2;
    }
  }

  static Color button(BuildContext context, String theme) {
    switch (theme) {
      case 'dark':
        return darkButton;
      case 'blueNavy':
        return blueNavyBackground2;
      case 'golden':
        return goldenButton;
      case 'light':
      default:
        return lightButton;
    }
  }

  static Color gray(BuildContext context, String theme) {
    switch (theme) {
      case 'dark':
        return darkGray;
      case 'blueNavy':
        return blueNavyBackground2;
      case 'golden':
        return goldenBackground2;
      case 'light':
      default:
        return lightGray;
    }
  }
  static Color scaffold(BuildContext context, String theme) {
    switch (theme) {
      case 'dark':
        return Colors.black12;
      case 'blueNavy':
        return blueNavyGray;
      case 'golden':
        return  Colors.amber.shade100;
      case 'light':
      default:
        return Colors.black12;
    }
  }


  static Color black(BuildContext context, String theme) {
    switch (theme) {
      case 'dark':
        return darkBlack;
      case 'blueNavy':
        return blueNavyBlack;
      case 'golden':
        return goldenBlack;
      case 'light':
      default:
        return lightBlack;
    }
  }

  static Color white(BuildContext context, String theme) {
    switch (theme) {
      case 'dark':
        return darkWhite;
      case 'blueNavy':
        return blueNavyWhite;
      case 'golden':
        return goldenWhite;
      case 'light':
      default:
        return lightWhite;
    }
  }

  static Color card(BuildContext context, String theme) {
    switch (theme) {
      case 'dark':
        return darkBackground2;
      case 'blueNavy':
        return blueNavyBackground2;
      case 'golden':
        return goldenBackground2;
      case 'light':
      default:
        return lightBackground2;
    }
  }

  static Color primary(BuildContext context, String theme) {
    switch (theme) {
      case 'dark':
        return darkButton;
      case 'blueNavy':
        return blueNavyBackground2;
      case 'golden':
        return goldenButton;
      case 'light':
      default:
        return lightButton;
    }
  }

  static Color SideBar(BuildContext context, String theme) {
    switch (theme) {
      case 'dark':
        return darkBackground;
      case 'blueNavy':
        return darkBackground;
      case 'golden':
        return darkBackground;
      case 'light':
      default:
        return lightBackground2;
    }
  }

  static Color onPrimary(BuildContext context, String theme) {
    return white(context, theme);
  }

  static Color textPrimary(BuildContext context, String theme) {
    return font(context, theme);
  }

  static Color textSecondary(BuildContext context, String theme) {
    return gray(context, theme);
  }
}
