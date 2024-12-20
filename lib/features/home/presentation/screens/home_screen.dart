import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../shared/widgets/orange_button.dart';
import '../../../placement_field/presentation/screens/placement_field_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> onNavigateToBattleField(BuildContext context) async {
    unawaited(
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlacementFieldScreen()),
      ),
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
            onTap: () async => onNavigateToBattleField(context),
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
