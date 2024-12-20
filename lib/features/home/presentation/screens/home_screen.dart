import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_prog_genius/features/placement_field/presentation/screens/placement_field_screen.dart';
import 'package:test_prog_genius/gen/assets.gen.dart';

import '../../../../shared/widgets/orange_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void onNavigateToBattleField(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlacementFieldScreen()),
    );
  }

  void onExit() => exit(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 60),
          Image.asset(Assets.images.logo.logo.path),
          const Spacer(),
          OrangeButton(
            onTap: () => onNavigateToBattleField(context),
            label: 'Play',
          ),
          const SizedBox(height: 16),
          OrangeButton(
            onTap: onExit,
            label: 'Exit',
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
