import 'package:flutter/material.dart';
import '../screens/placement_field_screen.dart';

class FieldSymbol extends StatelessWidget {
  const FieldSymbol({super.key, required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: PlacementFieldScreen.getCellSize(context),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: 19,
            color: Colors.white54,
          ),
        ),
      ),
    );
  }
}
