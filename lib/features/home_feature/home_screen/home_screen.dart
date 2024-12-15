import 'package:flutter/material.dart';
import 'package:micit/core/widgets/app_bar/main_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'MICIT'),
    );
  }
}
