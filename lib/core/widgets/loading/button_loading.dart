import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../theme/adaptive_theme.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitFadingCircle(
      color: AppThemes.airForceBlue,
      size: 30,
    );
  }
}
