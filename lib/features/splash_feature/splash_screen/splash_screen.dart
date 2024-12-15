import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:micit/core/theme/adaptive_theme.dart';

import '../../../core/cubit/language_cubit.dart';
import '../../../core/dependency_injection/configure_dependencies.dart';
import '../../../core/helper/dio_helper.dart';
import '../../../core/helper/helper.dart';
import '../../../core/router/route_names.dart';
import '../../../core/widgets/image/custom_image_view.dart';

MediaQueryData mediaQueryData = MediaQueryData.fromView(ui.window);

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Define the initial and final positions of the image and the text
  double imageLeft = -216.0; // The width of the image
  double imageTop = 0.0;
  double textRight = -216.0; // The width of the text
  double textTop = 0.0;

  @override
  void initState() {
    Helper.getUserLang();
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      navigateToNextScreen();
    });
    // Start the animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        // Set the final positions to the center of the screen
        // Subtract the width of the image and divide by 2
        imageLeft = (mediaQueryData.size.width - 216) / 2;
        // Subtract the height of the image and divide by 2
        imageTop = (mediaQueryData.size.height - 192) / 2;
        // Subtract the width of the text and divide by 2
        textRight = (mediaQueryData.size.width - 290) / 2;
        // Add the height of the image and the vertical space
        textTop = imageTop + 192 + 9;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppThemes.airForceBlue,
      body: Stack(
        children: [
          AnimatedPositioned(
            // Use the left and top properties for the image
            left: imageLeft,
            top: 157,
            duration: const Duration(milliseconds: 1600),
            curve: Curves.easeOut,
            child: const Center(
              child: CustomImageView(
                imagePath: 'assets/images/logo.png',
                height: 192,
                width: 216,
                fit: BoxFit.contain,
              ),
            ),
          ),
          AnimatedPositioned(
            // Use the right and top properties for the text
            right: textRight,
            top: 350,
            duration: const Duration(milliseconds: 1600),
            curve: Curves.easeOut,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MICIT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 9),
                Text(
                  "Bevatel & ---------",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> navigateToNextScreen() async {
    final LanguageCubit languageCubit = serviceLocator<LanguageCubit>();
    Helper.isLoggedIn = await Helper.getUserLogged();
    DioHelper.init(lang: languageCubit.local);
    if (Helper.isLoggedIn) {
      context.go(AppRouteName.homeScreenRoute);
    } else {
      context.go(AppRouteName.loginScreenRoute);
    }
  }
}
