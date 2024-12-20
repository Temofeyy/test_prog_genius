import 'package:flutter/material.dart';

import '../models/ship.dart';
import '../screens/placement_field_screen.dart';

class ShipWidget extends StatelessWidget {
  final Ship ship;
  final bool isGhost;
  final double rotateQuarter;

  final int? touchPoint;
  final bool displayTouchPoint;

  const ShipWidget({
    super.key,
    required this.ship,
    required this.rotateQuarter,
    this.touchPoint,
    this.displayTouchPoint = false,
  }) : isGhost = false;

  const ShipWidget.ghost({
    super.key,
    required this.ship,
    this.touchPoint,
    required this.rotateQuarter,
    this.displayTouchPoint = false,
  }) : isGhost = true;

  @override
  Widget build(BuildContext context) {
    final draggedPointColor = Colors.red.withOpacity(0.5);
    final ghostColor = Colors.grey.withOpacity(0.5);
    final baseColor = Colors.grey[700];

    final cellSize = PlacementFieldScreen.getCellSize(context);

    return SizedBox(
      height: cellSize * ship.length,
      width: cellSize,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          if (displayTouchPoint)
            Column(
              children: List.generate(
                ship.length,
                (index) => Container(
                  width: cellSize,
                  height: cellSize,
                  decoration: BoxDecoration(
                    color: isGhost
                        ? index == touchPoint
                            ? draggedPointColor
                            : ghostColor
                        : baseColor,
                    border: Border.all(color: Colors.grey[600]!),
                  ),
                ),
              ),
            ),
          Image.asset(ship.imagePath, height: ship.length * cellSize),
        ],
      ),
    );
  }
}
