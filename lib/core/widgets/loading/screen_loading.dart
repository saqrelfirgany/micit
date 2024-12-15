import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../theme/adaptive_theme.dart';

class ScreenLoading extends StatelessWidget {
  const ScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitSpinningLines(
      color: AppThemes.airForceBlue,
      size: 40,
    );
  }
}
